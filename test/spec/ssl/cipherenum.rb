#! /usr/local/bin/ruby

require 'net/https'
require 'csv'

module Net
  class HTTP
    def set_context=(value)
      @ssl_context = OpenSSL::SSL::SSLContext.new #Create a new context
      @ssl_context &&= OpenSSL::SSL::SSLContext.new(value)
    end

  end
end

module Ciphers

  @@target_url = "localhost"
  @@port = 443
  @@accepted_ciphers = []
  @@rejected_ciphers = []
  protocol_versions = [:SSLv3, :TLSv1, :TLSv1_1, :TLSv1_2] # Protocol versions support

  def self.accepted_ciphers
    @@accepted_ciphers
  end

  def self.rejected_ciphers
    @@rejected_ciphers
  end

  module CipherTable

    attr_reader :CIPHERS

    class CipherSpec
      attr_reader :name, :protocol_version, :kXchange_alg, :kXchange_bits, :authN, :encryption_alg, :encryption_bits, :MAC, :strength, :mode
      def initialize(spec)
        @name = spec[2]
        @protocol_version = spec[3]
        kXchange_match = spec[4].match('Kx=(\w+)\(?(\d+)?\)?')
        @kXchange_alg = kXchange_match[1]
        @kXchange_bits = kXchange_match[2] ? kXchange_match[2].to_i : nil
        @authN = spec[5].match(/Au=(\w+)/)[1]
        encryption_match = spec[6].match(/Enc=(\w+)\((\d+)\)/)
        @encryption_alg = encryption_match[1]
        @encryption_bits = encryption_match[2].to_i
        @MAC = spec[7].match(/Mac=(\w+)/)[1]
        @strength = spec[8]
        @mode = CipherSpec::retrieve_mode(spec[0])
      end

      def self.retrieve_mode(cipher_code)
        official_name = IANA_CIPHERS.select{|suite| suite[0] == cipher_code}[0][1]
        return 'CBC' if official_name.match('CBC')
        return 'GCM' if official_name.match('GCM')
        return 'CCM' if official_name.match('CCM')
      end

      private


    end

    IANA_CIPHERS = CSV.read("spec/ssl/IANA_TLS_Cipher_suite_registry.csv")

    CIPHERS =  `openssl ciphers -V`.split(/\n/).map {|spec| l = spec.split}.map{|spec| Ciphers::CipherTable::CipherSpec.new(spec)}

  end

  def self.check_cipher(cipher_name, bits, version)
    output = `openssl s_client -port 443 -cipher #{cipher_name} -CApath /etc/ssl/certs  2>/dev/null << EOF \nGET /\nEOF`
    if output.match(/^\s+Cipher\s+:\s+([\w-]+)$/) then
      @@accepted_ciphers << "#{cipher_name}"
      puts "[+] Accepted\t #{bits} bits\t#{cipher_name}"
    else
      @@rejected_ciphers << "#{cipher_name}"
    end
  end

  protocol_versions.each do |version|
    cipher_set = OpenSSL::SSL::SSLContext.new(version).ciphers
    puts "\n============================================"
    puts version
    puts "============================================"

    cipher_set.each do |cipher_name, ignore_me_cipher_version, bits, ignore_me_algorithm_bits|
      check_cipher(cipher_name, bits, version)
    end
  end
  puts "Accepted ciphers:\n #{accepted_ciphers}"
  puts "Rejected ciphers:\n #{rejected_ciphers}"
end

#! /usr/local/bin/ruby

require 'net/https'

module Net
  class HTTP
    def set_context=(value)
      @ssl_context = OpenSSL::SSL::SSLContext.new #Create a new context
      @ssl_context &&= OpenSSL::SSL::SSLContext.new(value)
    end

#		ssl_context_accessor :ciphers
  end
end

module Ciphers

  target_url = "localhost"
  port = 443
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
      attr_reader :name, :protocol_version, :kXchange_alg, :kXchange_bits, :authN, :encryption_alg, :encryption_bits, :MAC, :strength
      def initialize(spec)
        @name = spec[0]
        @protocol_version = spec[1]
        kXchange_match = spec[2].match('Kx=(\w+)\(?(\d+)?\)?')
        @kXchange_alg = kXchange_match[1]
        @kXchange_bits = kXchange_match[2] ? kXchange_match[2].to_i : nil
        @authN = spec[3].match(/Au=(\w+)/)[1]
        encryption_match = spec[4].match(/Enc=(\w+)\((\d+)\)/)
        @encryption_alg = encryption_match[1]
        @encryption_bits = encryption_match[2].to_i
        @MAC = spec[5].match(/Mac=(\w+)/)[1]
        @strength = spec[6]
      end
    end

    CIPHERS =  `openssl ciphers -v`.split(/\n/).map {|spec| l = spec.split}.map{|spec| Ciphers::CipherTable::CipherSpec.new(spec)}



  end

  protocol_versions.each do |version|
    cipher_set = OpenSSL::SSL::SSLContext.new(version).ciphers
    #puts "\n============================================"
    #puts version
    #puts "============================================"

    cipher_set.each do |cipher_name, ignore_me_cipher_version, bits, ignore_me_algorithm_bits|
      request = Net::HTTP.new(target_url, port)
      request.use_ssl = true
      request.set_context = version
      request.ciphers = cipher_name
      request.verify_mode = OpenSSL::SSL::VERIFY_NONE
      begin
        response = request.get("/")
        @@accepted_ciphers << "#{cipher_name}"
      #  puts "[+] Accepted\t #{bits} bits\t#{cipher_name}"
      rescue OpenSSL::SSL::SSLError => e
        @@rejected_ciphers << "#{cipher_name}"
      #  puts "[-] Rejected\t #{bits} bits\t#{cipher_name}"
      rescue #Ignore all other Exceptions
      end
    end
  end
  puts "Accepted ciphers: #{accepted_ciphers}"
  puts "Rejected ciphers: #{rejected_ciphers}"
end

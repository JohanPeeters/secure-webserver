#! /usr/local/bin/ruby
require 'csv'

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
      attr_reader :name, :protocol_version, :kXchange_alg, :kXchange_bits, :authN, :encryption_alg, :encryption_bits, :MAC, :strength, :mode, :hexcode
      def initialize(spec)
        @name = spec[2]
        @protocol_version = spec[3]
        kXchange_match = spec[4].match('Kx=(\w+)\(?(\d+)?\)?')
        @kXchange_alg = kXchange_match[1]
        @kXchange_bits = kXchange_match[2] ? kXchange_match[2].to_i : nil
        @authN = spec[5].match(/Au=(\w+)/)[1]
        encryption_match = spec[6].match(/Enc=(\w+)\((\d+)\)/)
        if !encryption_match then  
			@encryption_alg = "None"
    	    @encryption_bits = 0
        else
	        @encryption_alg = encryption_match[1]
    	    @encryption_bits = encryption_match[2].to_i
    	end
        @MAC = spec[7].match(/Mac=(\w+)/)[1]
        @strength = spec[8]
        @hexcode = spec[0]
        @mode = CipherSpec::retrieve_mode(spec[0])
      end

	  def to_s
	  	return "#{protocol_version}\t#{hexcode}\t kx=#{kXchange_alg}\t kxbits=#{kXchange_bits}\tauth=#{authN}\t #{name}\tenc=#{encryption_alg}\tmode=#{mode}"
	  end

      private
      
      def self.retrieve_mode(cipher_code)
        return 'NO_SUCH_CIPHER_IN_IANA' if cipher_code.split(',').size > 2 
        official_name = IANA_CIPHERS.select{|suite| suite[0] == cipher_code}[0][1]
        return 'CBC' if official_name.match('CBC')
        return 'GCM' if official_name.match('GCM')
        return 'CCM' if official_name.match('CCM')
      end

    end

    IANA_CIPHERS = CSV.read("spec/ssl/IANA_TLS_Cipher_suite_registry.csv")

    CIPHERS =  `openssl ciphers -V -cipher ALL:COMPLEMENTOFALL:COMPLEMENTOFDEFAULT`.split(/\n/).map {|spec|spec.split}.map{|spec| Ciphers::CipherTable::CipherSpec.new(spec)} #.select{|spec| spec.mode != "NO_SUCH_CIPHER_IN_IANA"}

  end

  def self.check_cipher(spec)
  	cipher_name = spec.name
  	bits = spec.encryption_bits
  	version = spec.protocol_version
    output = `openssl s_client -port #{@@port} -cipher #{cipher_name} -CApath /etc/ssl/certs 2>/dev/null << EOF \nGET /\nEOF`
    if output.match(/^\s+Cipher\s+:\s+([\w-]+)$/) then
      @@accepted_ciphers << spec
    else
      @@rejected_ciphers << spec
    end
  end

  def print_ciphers
  	
  end
  
   Ciphers::CipherTable::CIPHERS.each do |spec|
#      puts spec.to_s
      check_cipher(spec)
   end
  
end

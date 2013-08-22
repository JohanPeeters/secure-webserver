#! /usr/local/bin/ruby
require 'csv'

module Ciphers

  @@target_url = "localhost"
  @@port = 443
  @@accepted_ciphers = []
  @@rejected_ciphers = []

  def self.accepted_ciphers
    @@accepted_ciphers
  end

  def self.rejected_ciphers
    @@rejected_ciphers
  end

  module CipherTable

    attr_reader :CIPHERS

    class ProtocolVersion

      attr_reader :version


      def initialize(version)
        @version = version
      end

      SSLv2 = new('SSLv2')
      SSLv3 = self.new('SSLv3')
      TLSv1 = self.new('TLSv1')
      TLSv1_1 = self.new('TLSv1.1')
      TLSv1_2 = self.new('TLSv1.2')

      def self.select(version)
        case version
          when 'SSLv2'
            SSLv2
          when 'SSLv3'
            SSLv3
          when 'TLSv1'
            TLSv1
          when 'TLSv1.1'
            TLSv1_1
          when 'TLSv1.2'
            TLSv1_2
        end
      end

      ORDERED_LIST = ['SSLv2', 'SSLv3', 'TLSv1', 'TLSv1.1', 'TLSv1.2']

      def <(other)
        ORDERED_LIST.index(@version) < ORDERED_LIST.index(other.version)
      end

      def to_s
        @version
      end

    end

    class CipherSpec
      attr_reader :name, :iana_name, :protocol_version, :kXchange_alg, :kXchange_bits, :authN, :encryption_alg, :encryption_bits, :MAC, :strength, :mode, :hexcode

      def initialize(spec)
        @name = spec[2]
        @iana_name = CipherSpec::retrieve_iana_name(spec[0])
        @protocol_version = ProtocolVersion.select(spec[3])
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
        @mode = CipherSpec::retrieve_mode(@iana_name)
      end

      def to_s
        return "#{protocol_version}\t#{hexcode}\t kx=#{kXchange_alg}  \tenc=#{encryption_alg}   \tmode=#{mode}   \tauth=#{authN}\t #{name}"
      end

      private

      def self.retrieve_iana_name(cipher_code)
        return 'NO_SUCH_CIPHER_IN_IANA' if cipher_code.split(',').size > 2
        IANA_CIPHERS.select { |suite| suite[0] == cipher_code }[0][1]
      end

      def self.retrieve_mode(official_name)
        return 'CBC' if official_name.match('CBC')
        return 'GCM' if official_name.match('GCM')
        return 'CCM' if official_name.match('CCM')
        return 'NO_SUCH_CIPHER_IN_IANA' if official_name.match('NO_SUCH_CIPHER_IN_IANA')
      end

    end

    IANA_CIPHERS = CSV.read("spec/ssl/IANA_TLS_Cipher_suite_registry.csv")

    CIPHERS = `openssl ciphers -V -cipher ALL:COMPLEMENTOFALL:COMPLEMENTOFDEFAULT`
    .split(/\n/)
    .map { |spec| spec.split }
    .map { |spec| Ciphers::CipherTable::CipherSpec.new(spec) }

  end

  def self.request_welcome_page(cipher_name)
    `openssl s_client -port #{@@port} -cipher #{cipher_name} -CApath /etc/ssl/certs 2>/dev/null << EOF \nGET /\nEOF`
  end

  def self.print_ciphers
    puts "Accepted ciphers:\n"
    accepted_ciphers.each do |spec|
      puts spec.to_s
    end

=begin
    puts "Rejected ciphers:\n"
    rejected_ciphers.each do |spec|
      puts spec.to_s
    end
=end

  end

  def self.find_spec(name)
    output = Ciphers::CipherTable::CIPHERS.select { |spec| spec.iana_name == name }
    if output.size != 1 then
      output = Ciphers::CipherTable::CIPHERS.select { |spec| spec.name == name }
      return nil if output.size != 1
    end
    return output[0]
  end

  def self.print_cipher_def
    puts "Hexcode; Official name; OpenSSL name; Protocol version; Key Exchange Algoritm; Key Exchange Bit; Authentication method; Encryption Algoritm; Encryption Bits; Mode"
    Ciphers::CipherTable::CIPHERS.each do |spec|
      puts "#{spec.hexcode};#{spec.iana_name};#{spec.name};#{spec.protocol_version};#{spec.kXchange_alg};#{spec.kXchange_bits};#{spec.authN};#{spec.encryption_alg};#{spec.encryption_bits};#{spec.mode}"
    end
  end

  def self.check_cipher(spec)
    cipher_name = spec.name
    output = request_welcome_page(cipher_name)
    if output.match(/^\s+Cipher\s+:\s+([\w-]+)$/) then
      @@accepted_ciphers << spec
    else
      @@rejected_ciphers << spec
    end
  end

  Ciphers::CipherTable::CIPHERS.each do |spec|
    check_cipher(spec)
  end
end

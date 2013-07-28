#! /usr/local/bin/ruby

require 'net/https'


puts OpenSSL::Cipher.ciphers


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
  protocol_versions = [:SSLv3, :TLSv1, :TLSv1_2, :TLSv1_1] # Protocol versions support

  def self.accepted_ciphers
    @@accepted_ciphers
  end

  def self.rejected_ciphers
    @@rejected_ciphers
  end

  protocol_versions.each do |version|
    cipher_set = OpenSSL::SSL::SSLContext.new(version).ciphers
    puts "\n============================================"
    puts version
    puts "============================================"

    cipher_set.each do |cipher_name, ignore_me_cipher_version, bits, ignore_me_algorithm_bits|
      request = Net::HTTP.new(target_url, port)
      request.use_ssl = true
      request.set_context = version
      request.ciphers = cipher_name
      request.verify_mode = OpenSSL::SSL::VERIFY_NONE
      begin
        response = request.get("/")
        @@accepted_ciphers << "#{version}-#{cipher_name}"
        puts "[+] Accepted\t #{bits} bits\t#{cipher_name}"
      rescue OpenSSL::SSL::SSLError => e
        @@rejected_ciphers << "#{version}-#{cipher_name}"
        puts "[-] Rejected\t #{bits} bits\t#{cipher_name}"
      rescue #Ignore all other Exceptions
      end
    end
  end
  puts "Accepted ciphers: #{accepted_ciphers}"
  puts "Rejected ciphers: #{rejected_ciphers}"
end

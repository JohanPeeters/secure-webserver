#! /usr/local/bin/ruby

require 'net/https'

target_url = "localhost"
port = 443

puts OpenSSL::Cipher.ciphers

protocol_versions = [:SSLv2, :SSLv3, :TLSv1, :TLSv1_2, :TLSv1_1] # Protocol versions support

module Net 
	class HTTP 
		def set_context=(value) 
			@ssl_context = OpenSSL::SSL::SSLContext.new #Create a new context 
			@ssl_context &&= OpenSSL::SSL::SSLContext.new(value) 
		end 
		
#		ssl_context_accessor :ciphers 
	end
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
			puts "[+] Accepted\t #{bits} bits\t#{cipher_name}" 
		rescue OpenSSL::SSL::SSLError => e 
			puts "[-] Rejected\t #{bits} bits\t#{cipher_name}" 
		rescue #Ignore all other Exceptions 
		end 
	end
end

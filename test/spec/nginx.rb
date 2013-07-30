require "net/http"
require "net/https"
require "uri"
require "/vagrant/test/spec/ssl/cipherenum"


describe "nginx" do

  RootCA = '/etc/ssl/certs'

  it "is running" do
    uri = URI.parse("http://localhost/")
    # Shortcut
    response = Net::HTTP.get_response(uri)
  end

  it "serves the welcome page over http" do
    uri = URI.parse("http://localhost/")
    # Shortcut
    response = Net::HTTP.get_response(uri)
    
    response.code.should eq('200')
    
    file = File.open("/vagrant/test/modules/httpsdemo/files/www/localhost/index.html", "rb")
    contents = file.read

    response.body.should eq(contents)
  end

  it "serves the welcome page over https" do
    uri = URI.parse("https://localhost/")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    response.code.should eq('200')

    file = File.open("/vagrant/test/modules/httpsdemo/files/www/localhost/index.html", "rb")
    contents = file.read

    response.body.should eq(contents)
  end

  it "has a valid certificate over https" do
    uri = URI.parse("https://localhost/")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
  	http.ca_path = RootCA
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  	http.verify_depth = 5
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
  end


  it "supports only the predefined cipher suites" do
    accepted = Ciphers::accepted_ciphers
    accepted.should match_array ["ECDHE-RSA-AES256-SHA", "DHE-RSA-AES256-SHA", "DHE-RSA-CAMELLIA256-SHA", "AES256-SHA", "CAMELLIA256-SHA", "ECDHE-RSA-DES-CBC3-SHA", "EDH-RSA-DES-CBC3-SHA", "DES-CBC3-SHA", "ECDHE-RSA-AES128-SHA", "DHE-RSA-AES128-SHA", "DHE-RSA-CAMELLIA128-SHA", "AES128-SHA", "CAMELLIA128-SHA", "ECDHE-RSA-AES256-SHA", "DHE-RSA-AES256-SHA", "DHE-RSA-CAMELLIA256-SHA", "AES256-SHA", "CAMELLIA256-SHA", "ECDHE-RSA-DES-CBC3-SHA", "EDH-RSA-DES-CBC3-SHA", "DES-CBC3-SHA", "ECDHE-RSA-AES128-SHA", "DHE-RSA-AES128-SHA", "DHE-RSA-CAMELLIA128-SHA", "AES128-SHA", "CAMELLIA128-SHA", "ECDHE-RSA-AES256-SHA", "DHE-RSA-AES256-SHA", "DHE-RSA-CAMELLIA256-SHA", "AES256-SHA", "CAMELLIA256-SHA", "ECDHE-RSA-DES-CBC3-SHA", "EDH-RSA-DES-CBC3-SHA", "DES-CBC3-SHA", "ECDHE-RSA-AES128-SHA", "DHE-RSA-AES128-SHA", "DHE-RSA-CAMELLIA128-SHA", "AES128-SHA", "CAMELLIA128-SHA", "ECDHE-RSA-AES256-SHA", "DHE-RSA-AES256-SHA", "DHE-RSA-CAMELLIA256-SHA", "AES256-SHA", "CAMELLIA256-SHA", "ECDHE-RSA-DES-CBC3-SHA", "EDH-RSA-DES-CBC3-SHA", "DES-CBC3-SHA", "ECDHE-RSA-AES128-SHA", "DHE-RSA-AES128-SHA", "DHE-RSA-CAMELLIA128-SHA", "AES128-SHA", "CAMELLIA128-SHA"]

=begin
    (["SSLv3-AES128-SHA",
    							 "SSLv3-AES256-SHA",
    							 "SSLv3-CAMELLIA128-SHA", 
								"SSLv3-CAMELLIA256-SHA", 
								"SSLv3-DES-CBC3-SHA", 
								"SSLv3-DHE-RSA-AES128-SHA", 
								"SSLv3-DHE-RSA-AES256-SHA", 
								"SSLv3-DHE-RSA-CAMELLIA128-SHA", 
								"SSLv3-DHE-RSA-CAMELLIA256-SHA", 
								"SSLv3-ECDHE-RSA-AES128-SHA", 
								"SSLv3-ECDHE-RSA-AES256-SHA", 
								"SSLv3-ECDHE-RSA-DES-CBC3-SHA", 
								"SSLv3-EDH-RSA-DES-CBC3-SHA", 
								"TLSv1-AES128-SHA", 
								"TLSv1-AES256-SHA", 
								"TLSv1-CAMELLIA128-SHA", 
								"TLSv1-CAMELLIA256-SHA", 
								"TLSv1-DES-CBC3-SHA", 
								"TLSv1-DHE-RSA-AES128-SHA", 
								"TLSv1-DHE-RSA-AES256-SHA", 
								"TLSv1-DHE-RSA-CAMELLIA128-SHA", 
								"TLSv1-DHE-RSA-CAMELLIA256-SHA", 
								"TLSv1-ECDHE-RSA-AES128-SHA", 
								"TLSv1-ECDHE-RSA-AES256-SHA", 
								"TLSv1-ECDHE-RSA-DES-CBC3-SHA", 
								"TLSv1-EDH-RSA-DES-CBC3-SHA", 
								"TLSv1_1-AES128-SHA", 
								"TLSv1_1-AES256-SHA", 
								"TLSv1_1-CAMELLIA128-SHA", 
								"TLSv1_1-CAMELLIA256-SHA", 
								"TLSv1_1-DES-CBC3-SHA", 
								"TLSv1_1-DHE-RSA-AES128-SHA", 
								"TLSv1_1-DHE-RSA-AES256-SHA", 
								"TLSv1_1-DHE-RSA-CAMELLIA128-SHA", 
								"TLSv1_1-DHE-RSA-CAMELLIA256-SHA", 
								"TLSv1_1-ECDHE-RSA-AES128-SHA", 
								"TLSv1_1-ECDHE-RSA-AES256-SHA", 
								"TLSv1_1-ECDHE-RSA-DES-CBC3-SHA", 
								"TLSv1_1-EDH-RSA-DES-CBC3-SHA", 
								"TLSv1_2-AES128-SHA", 
								"TLSv1_2-AES256-SHA", 
								"TLSv1_2-CAMELLIA128-SHA", 
								"TLSv1_2-CAMELLIA256-SHA", 
								"TLSv1_2-DES-CBC3-SHA", 
								"TLSv1_2-DHE-RSA-AES128-SHA", 
								"TLSv1_2-DHE-RSA-AES256-SHA", 
								"TLSv1_2-DHE-RSA-CAMELLIA128-SHA", 
								"TLSv1_2-DHE-RSA-CAMELLIA256-SHA", 
								"TLSv1_2-ECDHE-RSA-AES128-SHA", 
								"TLSv1_2-ECDHE-RSA-AES256-SHA", 
								"TLSv1_2-ECDHE-RSA-DES-CBC3-SHA"
								])
=end
  end

  cipher_facts = `openssl ciphers -v`.split(/\n/)
                                    .map {|spec| l = spec.split}


  it 'does not support DES encryption' do
    specs_to_avoid = cipher_facts.select{|line| line[4].start_with?('Enc=DES')}
                                        .map{|line| line[0]}
    puts "specs to avoid are #{specs_to_avoid}"
    Ciphers::accepted_ciphers.should_not include(*specs_to_avoid)
  end

  it 'does not support export strength encryption' do
    specs_to_avoid = cipher_facts.select{|line| line.size > 6?line[6].eql?('export'):false}
                                    .map{|line| line[0]}
    puts "specs to avoid are #{specs_to_avoid}"
    Ciphers::accepted_ciphers.should_not include(*specs_to_avoid)
  end


end


#     accepted.should match_array(["SSLv3-ECDHE-RSA-AES256-SHA", 

#     					"SSLv3-DHE-RSA-AES256-SHA", 
#     					"SSLv3-DHE-RSA-CAMELLIA256-SHA", 
#     					"SSLv3-AES256-SHA", 
#     					"SSLv3-CAMELLIA256-SHA", 
# #    					"SSLv3-ECDHE-RSA-DES-CBC3-SHA",  			# ???????
# #    					"SSLv3-EDH-RSA-DES-CBC3-SHA",  			# ???????
# #    					"SSLv3-DES-CBC3-SHA",  			# ???????
#     					"SSLv3-ECDHE-RSA-AES128-SHA", 
#     					"SSLv3-DHE-RSA-AES128-SHA", 
#     					"SSLv3-DHE-RSA-CAMELLIA128-SHA", 
#     					"SSLv3-AES128-SHA", 
#     					"SSLv3-CAMELLIA128-SHA", 
#     					"TLSv1-ECDHE-RSA-AES256-SHA", 
#     					"TLSv1-DHE-RSA-AES256-SHA", 
#     					"TLSv1-DHE-RSA-CAMELLIA256-SHA", 
#     					"TLSv1-AES256-SHA", 
#     					"TLSv1-CAMELLIA256-SHA", 
# #    					"TLSv1-ECDHE-RSA-DES-CBC3-SHA",  			# ???????
# #    					"TLSv1-EDH-RSA-DES-CBC3-SHA",  			# ???????
# #    					"TLSv1-DES-CBC3-SHA",  			# ???????
#     					"TLSv1-ECDHE-RSA-AES128-SHA", 
#     					"TLSv1-DHE-RSA-AES128-SHA", 
#     					"TLSv1-DHE-RSA-CAMELLIA128-SHA", 
#     					"TLSv1-AES128-SHA", 
#     					"TLSv1-CAMELLIA128-SHA", 
#     					"TLSv1_2-ECDHE-RSA-AES256-SHA", 
#     					"TLSv1_2-DHE-RSA-AES256-SHA", 
#     					"TLSv1_2-DHE-RSA-CAMELLIA256-SHA", 
#     					"TLSv1_2-AES256-SHA", 
#     					"TLSv1_2-CAMELLIA256-SHA", 
# #    					"TLSv1_2-ECDHE-RSA-DES-CBC3-SHA",  			# ???????
# #    					"TLSv1_2-EDH-RSA-DES-CBC3-SHA",  			# ???????
# #    					"TLSv1_2-DES-CBC3-SHA",  			# ???????
#     					"TLSv1_2-ECDHE-RSA-AES128-SHA", 
#     					"TLSv1_2-DHE-RSA-AES128-SHA", 
#     					"TLSv1_2-DHE-RSA-CAMELLIA128-SHA", 
#     					"TLSv1_2-AES128-SHA", 
#     					"TLSv1_2-CAMELLIA128-SHA", 
#     					"TLSv1_1-ECDHE-RSA-AES256-SHA", 
#     					"TLSv1_1-DHE-RSA-AES256-SHA", 
#     					"TLSv1_1-DHE-RSA-CAMELLIA256-SHA", 
#     					"TLSv1_1-AES256-SHA", 
#     					"TLSv1_1-CAMELLIA256-SHA", 
# #    					"TLSv1_1-ECDHE-RSA-DES-CBC3-SHA",  			# ???????
# #    					"TLSv1_1-EDH-RSA-DES-CBC3-SHA",	 			# ???????
# #    					"TLSv1_1-DES-CBC3-SHA", 			# ???????
#     					"TLSv1_1-ECDHE-RSA-AES128-SHA", 
#     					"TLSv1_1-DHE-RSA-AES128-SHA", 
#     					"TLSv1_1-DHE-RSA-CAMELLIA128-SHA", 
#     					"TLSv1_1-AES128-SHA", 
#     					"TLSv1_1-CAMELLIA128-SHA"])

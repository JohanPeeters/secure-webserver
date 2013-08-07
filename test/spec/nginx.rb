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

  it 'only supports encryption keys that are at least 128 bits long' do
    do_not_include{|cipher_spec| cipher_spec.encryption_bits < 128}
  end

  it 'does not support DES encryption' do
    do_not_include{|cipher_spec| cipher_spec.encryption_alg == 'DES'}
  end

  it 'does not support export strength encryption' do
    do_not_include{|cipher_spec| cipher_spec.strength == 'export'}
  end

  it 'is impervious to the Lucky 13 attack' do
    do_not_include{|cipher_spec| cipher_spec.mode == 'CBC'}
  end

  it 'does not support Anonymous Diffie-Hellman' do

  end

  def do_not_include(&fn)
    specs_to_avoid = Ciphers::CipherTable::CIPHERS.select(&fn)
          .map{|cipher_spec| cipher_spec.name}
    to_be_removed = Ciphers::accepted_ciphers.select{|cipher| specs_to_avoid.include?(cipher)}
    puts "specs that need to be removed: #{to_be_removed}" unless to_be_removed.empty?
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

require "net/http"
require "net/https"
require "uri"


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

  it "is at least version 1.4.2" do
    result = `nginx -v 2>&1`
    result.should match(/.*\/1\.4\.2/)
  end

	# fix with openssl commando : openssl s_client -port 443 -CApath /etc/ssl/certs/
  it "has a valid certificate over https" do
    uri = URI.parse("https://localhost/")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
  	http.ca_path = RootCA
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  	http.verify_depth = 5
  	http.ciphers = "ALL"
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    response.code.should eq('200')
  end

end

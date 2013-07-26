require "net/http"
require "net/https"
require "uri"


describe "nginx" do
  it "is running" do
    uri = URI.parse("http://localhost/")
	# Shortcut
	response = Net::HTTP.get_response(uri)
  end
  
  it "is running on https" do
    uri = URI.parse("https://localhost/")
	# Shortcut
	response = Net::HTTP.get_response(uri)
  end
  
  it "serves the welcome page" do
    uri = URI.parse("https://localhost/")
    
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true 
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Get.new(uri.request_uri)
	response = http.request(request)
	
	
	file = File.open("/vagrant/test/modules/httpsdemo/files/www/nginx-default/index.html", "rb")
	contents = file.read
	
	
	
	
	response.body.should eq(contents)
  end
  
  
end
require "net/http"
require "net/https"
require "uri"
require "./spec/ssl/cipherenum"

uri = URI.parse("https://localhost/")

describe "nginx_config" do

  it "is at least version 1.4.2" do
    result = `nginx -v 2>&1`
    result.should match(/.*\/1\.4\.2/)
  end

  it "has not compression in TLS headers (no CRIME)" do
  	output = Ciphers::request_welcome_page('ALL')
  	output.should match(/^Compression:\s+NONE$/)
  end
  
  xit "has no support for insecure renegotiation" do
  	true.should eq false
  	# https://github.com/iSECPartners/sslyze
  end
  
  it "HTTP Strict Transport Security" do
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    hsts = response['Strict-Transport-Security']
    hsts.should_not be_nil 
    
    # max-age=31536000;
    hsts.should match(/^max-age=.*/)
	hsts.match(/^max-age=(.*)/)[1].to_i.should be >= 31536000    
  end

  it "has GZIP disabled against BREACH" do
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri,{ "Accept-Encoding" => "gzip"})
   
    response = http.request(request)

    compression = response.header['Content-Encoding']
    
    if compression != nil then 
	    compression.should match(/^identity$/)
    end
  end

end

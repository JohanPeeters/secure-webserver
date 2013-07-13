require "net/http"
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
end
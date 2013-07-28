require "net/http"
require "net/https"
require "uri"
require "/vagrant/test/spec/ssl/cipherenum"


describe "nginx" do
  it "is running" do
    uri = URI.parse("http://localhost/")
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


    file = File.open("/vagrant/test/modules/httpsdemo/files/www/localhost/index.html", "rb")
    contents = file.read

    response.body.should eq(contents)
  end

  it "supports the white-listed cipher suites" do
    accepted = Ciphers::accepted_ciphers
    accepted.should eq(["SSLv3-ECDHE-RSA-AES256-SHA", "SSLv3-DHE-RSA-AES256-SHA", "SSLv3-DHE-RSA-CAMELLIA256-SHA", "SSLv3-AES256-SHA", "SSLv3-CAMELLIA256-SHA", "SSLv3-ECDHE-RSA-DES-CBC3-SHA", "SSLv3-EDH-RSA-DES-CBC3-SHA", "SSLv3-DES-CBC3-SHA", "SSLv3-ECDHE-RSA-AES128-SHA", "SSLv3-DHE-RSA-AES128-SHA", "SSLv3-DHE-RSA-CAMELLIA128-SHA", "SSLv3-AES128-SHA", "SSLv3-CAMELLIA128-SHA", "TLSv1-ECDHE-RSA-AES256-SHA", "TLSv1-DHE-RSA-AES256-SHA", "TLSv1-DHE-RSA-CAMELLIA256-SHA", "TLSv1-AES256-SHA", "TLSv1-CAMELLIA256-SHA", "TLSv1-ECDHE-RSA-DES-CBC3-SHA", "TLSv1-EDH-RSA-DES-CBC3-SHA", "TLSv1-DES-CBC3-SHA", "TLSv1-ECDHE-RSA-AES128-SHA", "TLSv1-DHE-RSA-AES128-SHA", "TLSv1-DHE-RSA-CAMELLIA128-SHA", "TLSv1-AES128-SHA", "TLSv1-CAMELLIA128-SHA", "TLSv1_2-ECDHE-RSA-AES256-SHA", "TLSv1_2-DHE-RSA-AES256-SHA", "TLSv1_2-DHE-RSA-CAMELLIA256-SHA", "TLSv1_2-AES256-SHA", "TLSv1_2-CAMELLIA256-SHA", "TLSv1_2-ECDHE-RSA-DES-CBC3-SHA", "TLSv1_2-EDH-RSA-DES-CBC3-SHA", "TLSv1_2-DES-CBC3-SHA", "TLSv1_2-ECDHE-RSA-AES128-SHA", "TLSv1_2-DHE-RSA-AES128-SHA", "TLSv1_2-DHE-RSA-CAMELLIA128-SHA", "TLSv1_2-AES128-SHA", "TLSv1_2-CAMELLIA128-SHA", "TLSv1_1-ECDHE-RSA-AES256-SHA", "TLSv1_1-DHE-RSA-AES256-SHA", "TLSv1_1-DHE-RSA-CAMELLIA256-SHA", "TLSv1_1-AES256-SHA", "TLSv1_1-CAMELLIA256-SHA", "TLSv1_1-ECDHE-RSA-DES-CBC3-SHA", "TLSv1_1-EDH-RSA-DES-CBC3-SHA", "TLSv1_1-DES-CBC3-SHA", "TLSv1_1-ECDHE-RSA-AES128-SHA", "TLSv1_1-DHE-RSA-AES128-SHA", "TLSv1_1-DHE-RSA-CAMELLIA128-SHA", "TLSv1_1-AES128-SHA", "TLSv1_1-CAMELLIA128-SHA"])
  end


end

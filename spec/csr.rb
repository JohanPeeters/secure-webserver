describe "certificate signing request" do
  it "has been generated" do
    File.exists?('/etc/nginx/cert/certreq.csr').should be_true
  end
end

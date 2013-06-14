describe "certificate" do
  it "has been signed" do
    File.exists?('/etc/nginx/cert/certsigned.crt').should be_true
  end
end

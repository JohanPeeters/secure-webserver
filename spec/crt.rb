describe "certificate" do
  it "has been signed" do
    File.exists?('/etc/ssl/certs/certsigned.crt').should be_true
  end
end

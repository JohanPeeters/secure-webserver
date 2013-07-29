describe "certificate authority for testing" do
  it "has been generated" do
    File.exists?('/vagrant/ca/ca_key.key').should be_true
    File.exists?('/vagrant/ca/ca_cert.crt').should be_true
  end
end

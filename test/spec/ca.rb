describe "certificate authority for testing" do
  it "has been generated" do
    File.exists?('/ca/ca_key.key').should be_true
    File.exists?('/ca/ca_cert.crt').should be_true
  end
end

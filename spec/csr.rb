describe "private key" do
	it "has been generated" do
		File.exists?('/etc/ssl/private/keys.key').should be_true
	end
end

describe "certificate signing request" do
  it "has been generated" do
    File.exists?('/etc/ssl/certs/certreq.csr').should be_true
  end
end



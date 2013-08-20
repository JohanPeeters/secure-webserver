require "./spec/ssl/cipherenum"

describe "compatability" do
	
  compatability_cipher = 'ECDHE-RSA-RC4-SHA'

  IE_on_win_xp_2000_2003 = "TLS_RSA_WITH_RC4_128_MD5,TLS_RSA_WITH_RC4_128_SHA,TLS_RSA_WITH_3DES_EDE_CBC_SHA,TLS_RSA_WITH_DES_CBC_SHA,TLS_RSA_EXPORT1024_WITH_RC4_56_SHA,TLS_RSA_EXPORT1024_WITH_DES_CBC_SHA,TLS_RSA_EXPORT_WITH_RC4_40_MD5,TLS_RSA_EXPORT_WITH_RC2_CBC_40_MD5,TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA,TLS_DHE_DSS_WITH_DES_CBC_SHA,TLS_DHE_DSS_EXPORT1024_WITH_DES_CBC_SHA".split(",").map{|name| Ciphers::find_spec(name)}
  IE_on_vista = "TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_RC4_128_SHA,TLS_RSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_DHE_DSS_WITH_AES_128_CBC_SHA,TLS_DHE_DSS_WITH_AES_256_CBC_SHA,TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA,TLS_RSA_WITH_RC4_128_MD5".split(",").map{|name| Ciphers::find_spec(name)}   
  Firefox_chrome = "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_DHE_RSA_WITH_CAMELLIA_256_CBC_SHA,TLS_DHE_DSS_WITH_CAMELLIA_256_CBC_SHA,TLS_DHE_RSA_WITH_AES_256_CBC_SHA,TLS_DHE_DSS_WITH_AES_256_CBC_SHA,TLS_ECDH_RSA_WITH_AES_256_CBC_SHA,TLS_ECDH_ECDSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_CAMELLIA_256_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_ECDSA_WITH_RC4_128_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_RC4_128_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_CAMELLIA_128_CBC_SHA,TLS_DHE_DSS_WITH_CAMELLIA_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_DSS_WITH_AES_128_CBC_SHA,TLS_ECDH_RSA_WITH_RC4_128_SHA,TLS_ECDH_RSA_WITH_AES_128_CBC_SHA,TLS_ECDH_ECDSA_WITH_RC4_128_SHA,TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_CAMELLIA_128_CBC_SHA,TLS_RSA_WITH_RC4_128_MD5,TLS_RSA_WITH_RC4_128_SHA,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA,TLS_DHE_RSA_WITH_3DES_EDE_CBC_SHA,TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA,TLS_ECDH_RSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDH_ECDSA_WITH_3DES_EDE_CBC_SHA,SSL_RSA_FIPS_WITH_3DES_EDE_CBC_SHA,TLS_RSA_WITH_3DES_EDE_CBC_SHA".split(",").map{|name| Ciphers::find_spec(name)}
  
   
  it 'supports a compatible ciphers for older systems without GCM' do
  	Ciphers::accepted_ciphers.map{|spec| spec.name}.include?(compatability_cipher).should be true
  end
  
  xit 'supports IE 6, 7, 8 on windows xp, 2003 or 2000 systems' do
  	output = Ciphers::accepted_ciphers & IE_on_win_xp_2000_2003
  	output.should_not be_empty
  end
  
  xit 'supports IE 6, 7, 8 on windows vista' do
  	output = Ciphers::accepted_ciphers & IE_on_vista
  	output.should_not be_empty
  end
  
  it 'supports firefox and chrome' do
  	output = Ciphers::accepted_ciphers & Firefox_chrome
  	output.should_not be_empty
  end
  
  it 'prefers safe ciphers over compatability ciphers' do
  	output = Ciphers::request_welcome_page(compatability_cipher+":TLSv1.2")
  	output.should_not match(/#{compatability_cipher}/)
  	output = Ciphers::request_welcome_page("TLSv1.2:#{compatability_cipher}")
  	output.should_not match(/#{compatability_cipher}/)

  end
end

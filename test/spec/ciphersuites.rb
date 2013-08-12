require "net/http"
require "net/https"
require "uri"
require "./spec/ssl/cipherenum"


describe "ciphersuites" do

  it 'only supports encryption keys that are at least 128 bits long' do
    do_not_include{|cipher_spec| cipher_spec.encryption_bits < 128}
  end

  it 'does not support unencrypted connections' do
  	do_not_include{|cipher_spec| cipher_spec.encryption_alg == 'None'}
  end

  it 'does not support anoumous connections' do
  	do_not_include{|cipher_spec| cipher_spec.authN == 'None'}
  end

  it 'does not support DES encryption' do
    do_not_include{|cipher_spec| cipher_spec.encryption_alg == 'DES'}
  end

  it 'does not support RSA key exchange to prevent problems with forward secrecy' do
    do_not_include{|cipher_spec| cipher_spec.kXchange_alg == 'RSA'}
  end

  it 'does not support RC4 encryption' do
    do_not_include{|cipher_spec| cipher_spec.encryption_alg == 'RC4'}
  end

  it 'does not support export strength encryption' do
    do_not_include{|cipher_spec| cipher_spec.strength == 'export'}
  end

  it 'is impervious to the Lucky Thirteen attack' do
    do_not_include{|cipher_spec| cipher_spec.mode == 'CBC'}
  end

  def do_not_include(&fn)
    specs_to_avoid = Ciphers::CipherTable::CIPHERS.select(&fn)
          .map{|cipher_spec| cipher_spec.name}
    to_be_removed = Ciphers::accepted_ciphers.select{|cipher| specs_to_avoid.include?(cipher)}
    puts "specs that need to be removed: #{to_be_removed}" unless to_be_removed.empty?
    Ciphers::accepted_ciphers.should_not include(*specs_to_avoid)
  end

end

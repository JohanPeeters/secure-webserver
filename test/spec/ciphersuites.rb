require "net/http"
require "net/https"
require "uri"
require "./spec/ssl/cipherenum"

describe "ciphersuites" do
	
  compatability_cipher = 'ECDHE-RSA-RC4-SHA'

  it 'does not support unencrypted connections' do
    do_not_include{|cipher_spec| cipher_spec.encryption_alg == 'None'}
  end

  it 'does not support anonymous connections' do
    do_not_include{|cipher_spec| cipher_spec.authN == 'None'}
  end

  it 'does not support export strength encryption' do
    do_not_include{|cipher_spec| cipher_spec.strength == 'export'}
  end

  it 'does not support DES encryption' do
    do_not_include{|cipher_spec| cipher_spec.encryption_alg == 'DES'}
  end

  it 'only supports encryption keys that are at least 128 bits long' do
    do_not_include{|cipher_spec| cipher_spec.encryption_bits < 128}
  end

  it 'is impervious to the BEAST attack' do
    do_not_include{|cipher_spec| cipher_spec.mode == 'CBC' and cipher_spec.protocol_version < Ciphers::CipherTable::ProtocolVersion::TLSv1_1}
  end

  xit 'does not support RC4 encryption' do
    do_not_include{|cipher_spec| cipher_spec.encryption_alg == 'RC4'}
  end

  it 'is impervious to the Lucky 13 attack' do
    do_not_include{|cipher_spec| cipher_spec.mode == 'CBC'}
  end

  it 'does not support RSA, PSK or SRP key exchange to prevent problems with forward secrecy' do
    do_not_include{|cipher_spec| cipher_spec.kXchange_alg == 'RSA' || cipher_spec.kXchange_alg == 'PSK' || cipher_spec.kXchange_alg == 'SRP'}
  end

  def do_not_include(&fn)
    specs_to_avoid = Ciphers::CipherTable::CIPHERS.select(&fn)

    to_be_removed = Ciphers::accepted_ciphers & specs_to_avoid
    if !to_be_removed.empty? then
      puts "specs that need to be removed: "
      to_be_removed.each do |spec|
          puts spec.to_s
      end
    end
    to_be_removed.should be_empty, "to be removed: -" + to_be_removed.map{|spec| spec.name}.join(':-')
  end
  
end

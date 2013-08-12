require "net/http"
require "net/https"
require "uri"
require "./spec/ssl/cipherenum"

puts "Accepted ciphers:\n"
Ciphers::accepted_ciphers.each do |spec|
  puts "A " + spec.to_s
end

puts "Rejected ciphers:\n"
Ciphers::rejected_ciphers.each do |spec|
  puts spec.to_s
end

describe "ciphersuites" do

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

  it 'does not support RC4 encryption' do
    do_not_include{|cipher_spec| cipher_spec.encryption_alg == 'RC4'}
  end

  it 'is impervious to the Lucky Thirteen attack' do
    do_not_include{|cipher_spec| cipher_spec.mode == 'CBC'}
  end

  it 'does not support RSA key exchange to prevent problems with forward secrecy' do
    do_not_include{|cipher_spec| cipher_spec.kXchange_alg == 'RSA'}
  end

  def do_not_include(&fn)
    specs_to_avoid = Ciphers::CipherTable::CIPHERS.select(&fn)

    to_be_removed = Ciphers::accepted_ciphers.select{|spec| specs_to_avoid.include?(spec)}
    if !to_be_removed.empty? then
      puts "specs that need to be removed: "
      to_be_removed.each do |spec|
          puts spec.to_s
      end
    end
    to_be_removed.should be_empty
  end
end

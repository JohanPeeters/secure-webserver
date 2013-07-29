#!/bin/bash

echo '** updating apt-get packages'
apt-get update
echo '** all versions of Ruby available on Ubuntu or Debian via official apt-get repositories are known to be insecure'
echo 'so install from source.'
echo 'All ruby versions available on official repositories are Vulnerable to CommonName attack'
echo 'Not giving up on managing packages entirely, so first install checkinstall.'
apt-get -y install checkinstall=1.6.2-3ubuntu1
echo '** installing ruby 2.0.0-p247'
cd /tmp
wget -c --progress=bar http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar xzf ruby-2.0.0-p247.tar.gz
cd ruby-2.0.0-p247
./configure --disable-install-doc
make
checkinstall -y \
	--pkgversion 2.0.0-p247 \
	--provides "ruby-interpreter"
echo '** installing puppet'
gem install --version '= 3.2.1' puppet --no-ri --no-rdoc
echo '** installing puppet modules'
puppet module install puppetlabs/apt --version 1.2.0
echo '** installing rspec'
gem install --version '=2.14.1' rspec --no-ri --no-rdoc

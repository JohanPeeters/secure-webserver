#!/bin/bash

echo '** updating apt-get packages'
apt-get update
echo '** basebox (Ubuntu 12.04.2 - Precise Pangolin) runs an insecure version of Ruby, '
echo 'see CVE-2013-4073'
echo 'or http://www.ruby-lang.org/en/news/2013/06/27/hostname-check-bypassing-vulnerability-in-openssl-client-cve-2013-4073/'
echo 'Vulnerable to CommonName attack'
echo 'So we uninstall'
apt-get --purge remove ruby1.8
apt-get autoremove
echo "** all versions of Ruby available on Ubuntu or Debian via official apt-get repositories are known to be insecure'
echo 'so install from source.'
echo 'Not giving up on managing packages entirely, so first install checkinstall.'
apt-get -y install checkinstall=1.6.2-3ubuntu1
echo '** installing ruby 2.0.0-p247'
cd /tmp
wget -c http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar xzf ruby-2.0.0-p247.tar.gz
cd ruby-2.0.0-p247
./configure
make
checkinstall -y \
	--pkgversion 2.0.0-p247 \
	--provides "ruby-interpreter"
echo '** installing rubygems'
apt-get -y install rubygems=1.8.15-1ubuntu0.1
echo '** installing puppet'
gem install --version '= 3.2.1' puppet --no-ri --no-rdoc
echo '** installing puppet modules'
puppet module install puppetlabs/apt --version 1.2.0

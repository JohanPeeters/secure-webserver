#!/bin/bash

ROOT_DIR=/vagrant
echo '** updating apt-get packages'
apt-get update
echo '** all versions of Ruby available on Ubuntu or Debian via official apt-get repositories are known to be insecure'
echo 'so install from source.'
echo 'All ruby versions available on official repositories are Vulnerable to CommonName attack'
echo '** installing ruby 2.0.0-p247'
pkg_file=${ROOT_DIR}/ruby-2.0.0_2.0.0-p247-1_amd64.deb
if [ -e $pkg_file ]; then
	dpkg -i $pkg_file;
else
	${ROOT_DIR}/make_installation_package.sh;
fi
echo '** installing puppet'
gem install --version '= 3.2.1' puppet --no-ri --no-rdoc
echo '** installing puppet modules'
puppet module install puppetlabs/apt --version 1.2.0
echo '** installing rspec'
gem install --version '=2.14.1' rspec --no-ri --no-rdoc

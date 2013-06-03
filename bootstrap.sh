#!/bin/bash

#if [ ! -e /etc/apt/sources.list.d/puppet-main-precise.list ]; then 
#	echo "deb http://apt.puppetlabs.com/ precise main" > /etc/apt/sources.list.d/puppet-main-precise.list; 
#fi
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1054B7A24BD6EC30
apt-get update
apt-get -y install rubygems=1.8.15-1ubuntu0.1
#apt-get -y install puppet=2.7.21-1puppetlabs1
gem install --version '= 3.2.1' puppet --no-ri --no-rdoc
puppet module install puppetlabs/apt --version 1.1.0

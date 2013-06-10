#!/bin/bash

echo 'updating apt-get packages'
apt-get update
apt-get upgrade
echo 'installing rubygems'
apt-get -y install rubygems=1.8.15-1ubuntu0.1
echo 'installing puppet'
gem install --version '= 3.2.1' puppet --no-ri --no-rdoc
echo 'installing puppet modules'
puppet module install puppetlabs/apt --version 1.1.0

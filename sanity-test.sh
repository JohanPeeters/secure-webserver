#!/bin/bash  

if [ -n "$1" ]; then
	VAGRANT_BASE=$1
else 
	VAGRANT_BASE=$(dirname $0)/test
fi	
pushd $VAGRANT_BASE
echo "** running sanity tests **"

sudo rspec spec/csr.rb
sudo rspec spec/ca.rb
sudo rspec spec/crt.rb
sudo rspec spec/nginx.rb
sudo rspec spec/ciphersuites.rb
sudo rspec spec/nginx_config.rb

popd

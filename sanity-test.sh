#!/bin/bash  

if [ -n "$1" ]; then
	VAGRANT_BASE=$1
else 
	VAGRANT_BASE=$(dirname $0)/test
fi	

echo "** running sanity tests **"
sudo rspec $VAGRANT_BASE/spec/nginx.rb
sudo rspec $VAGRANT_BASE/spec/csr.rb
sudo rspec $VAGRANT_BASE/spec/ca.rb
sudo rspec $VAGRANT_BASE/spec/crt.rb

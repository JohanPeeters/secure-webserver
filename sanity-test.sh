#!/bin/bash  

if [ -n "$1" ]; then
	VAGRANT_BASE=$1
else 
	VAGRANT_BASE=$(dirname $0)/test
fi	
pushd $VAGRANT_BASE
echo "** running sanity tests **"

sudo rspec --format documentation spec/*

popd

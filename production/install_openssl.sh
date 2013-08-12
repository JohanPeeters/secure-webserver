#! /bin/bash

apt-get -y install checkinstall=1.6.2-3ubuntu1

pushd /tmp
wget -c --progress=bar http://www.openssl.org/source/openssl-1.0.1e.tar.gz
tar xzf openssl-1.0.1e.tar.gz
pushd openssl-1.0.1e
./Configure --prefix=/usr \
	 --openssldir=/usr/lib/ssl \
	 enable-ssl2 \
	 enable-sslv2 \
	 shared	\
	 zlib-dynamic \
	 linux-x86_64
checkinstall -y \
	--pkgversion 1.0.1e \
	--provides "openssl" \
	--pakdir=$ROOT_DIR  
make clean
popd
popd

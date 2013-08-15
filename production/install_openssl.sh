#! /bin/bash

apt-get -y remove libssl-dev
apt-get -y install checkinstall=1.6.2-3ubuntu1

pushd /tmp
wget -c --progress=bar http://www.openssl.org/source/openssl-1.0.1e.tar.gz
tar xzf openssl-1.0.1e.tar.gz
pushd openssl-1.0.1e

MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  linversion=linux-x86_64
else
  linversion=linux-elf
fi

echo $linversion

./Configure --prefix=/usr \
	 --openssldir=/usr/lib/ssl \
	 enable-ssl2 \
	 enable-sslv2 \
	 shared	\
	 zlib-dynamic \
	 $linversion
checkinstall -y \
	--pkgversion 1.0.1e \
	--provides "openssl" \
	--pakdir=$ROOT_DIR  
make clean
popd
popd

#! /bin/bash

apt-get -y install checkinstall=1.6.2-3ubuntu1

pushd /tmp
wget -c --progress=bar http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar xzf ruby-2.0.0-p247.tar.gz
pushd ruby-2.0.0-p247
./configure --disable-install-doc \
            --disable-install-rdoc	
checkinstall -y \
	--pkgversion 2.0.0-p247 \
	--provides "ruby-interpreter" \
	--pakdir=$ROOT_DIR
make clean

popd
popd

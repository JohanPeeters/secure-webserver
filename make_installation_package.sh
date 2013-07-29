
cd /tmp
wget -c --progress=bar http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar xzf ruby-2.0.0-p247.tar.gz
cd ruby-2.0.0-p247
./configure --disable-install-doc
checkinstall -y \
	--pkgversion 2.0.0-p247 \
	--provides "ruby-interpreter" \
	--nodoc
mv 
make clean

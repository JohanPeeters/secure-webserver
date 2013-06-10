export VAGRANT_BASE=/vagrant
echo "** installing rspec **"
gem install rspec --no-ri --no-rdoc
echo "** running sanity tests **"
rspec $VAGRANT_BASE/spec/nginx.rb
rspec $VAGRANT_BASE/spec/csr.rb

export VAGRANT_BASE=$(dirname $0)
VAGRANT_BASE=$1
echo "** running sanity tests **"
rspec $VAGRANT_BASE/spec/nginx.rb
rspec $VAGRANT_BASE/spec/csr.rb

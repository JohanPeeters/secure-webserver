Demo: Vagrant
=============

- useful tool in development: allows you to rool back VM to initial state easily.
    + `exit`
    + `vagrant destroy`

- bringing up a virtual machine as you wish it to be configured is easy
    + `vagrant up webserver`
    + runs a bootstrap script that (should) only install puppet
    + installation of Ruby and OpenSSL with `checkinstall`: compile, make deb package, install deb package in order not to completely alienate the Debian/Ubuntu package manager
    + runs the puppet manifests
    + runs the test suite

- rspec


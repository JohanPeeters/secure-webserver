secure-webserver
================

Installation scripts to set up a secure web server.
Installation scripts are provided as Puppet modules. There is also a Vagrantfile so that you can use vagrant while you are tweaking the installation.

Prerequisites
-------------

+ Vagrant
+ VirtualBox

Testing
-------

A `vagrant up` run includes some automatic tests (see `test/rspec`).
There is also some provision for manual tests; on the host, port 8080 is forwarded to port 80 on the guest and port 8443 to 443.
Hence the `http://localhost:8080` and `https://localhost:8443` base URLs can be used in a browser on the host.
Until the self-signed CA certificate constructed during `vagrant up` is added to the root certificates, browsers complain about the latter base URL.
A root certificate can be added on OS X by opening one of the keychains in use (e.g. `/Library/Keychains/System.keychain`), selecting `System Roots` > `Certificates` and dragging the CA certificate into it.
The CA certificate on the VM is in the `/ca` directory.
In order to access it on the host machine, it needs to be copied in `\vagrant`.
When this is done, it is accessible on the host in the root of the git repo.

Git gotcha
----------

If you are contributing to this project, here is a git nuisance that you need to know about:
the files `ca/serial` and `ca/index.txt` need to exist when running `vagrant up`.
So we put them in the git repository.
But they are changed each time `puppet apply`, and hence `vagrant up`, is run.
Since it is not desirable to check these files in with the new content, you should run 

	git update-index --assume-unchanged ca/index.txt
	git update-index --assume-unchanged ca/serial

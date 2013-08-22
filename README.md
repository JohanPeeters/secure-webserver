secure-webserver
================

This github repository contains a demonstration of setting up a HTTPS server with puppet. 

This repository contains:
* Vagrant definition of the virtual machine setup to play with this setup. This includes a set of scripts to get correct version of software on your machine (including puppet and openssl).
* Puppet for configuration of whole HTTPS server
* rspec tests for testing if the 


Prerequisites
-------------

Before starting your experimentation with this you at least need

+ Git
+ Vagrant
+ VirtualBox

Testing
-------

A `vagrant up` run includes some automatic tests (see `test/rspec`).
There is also some provision for manual tests; on the host, port 8080 is forwarded to port 80 on the guest and port 8443 to 443.
Hence the `http://localhost:8080` and `https://localhost:8443` base URLs can be used in a browser on the host.
Until the self-signed CA certificate constructed during `vagrant up` is added to the root certificates, browsers complain about the latter base URL.
To add a root certificate in OS X, follow the instructions in http://support.apple.com/kb/PH7297.
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

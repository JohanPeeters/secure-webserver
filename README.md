secure-webserver
================

This github repository contains a demonstration of setting up a HTTPS server with puppet. This is our experimentation environment that is used in the context of a talk at OWASP AppSec Research EU (https://appsec.eu). The presentation can be found at:




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

Getting started
-------

- Download the repository:

`git clone https://github.com/JohanPeeters/secure-webserver.git`

- Get the virtual machine up and running

`vagrant up prepuppet` for starting the virtual machine before running puppet. This sets up the basic virtual machine and installs necessary software until the puppet runtime. 

`vagrant up webserver` for starting the (full blown) webserver. This sets up nginx with a ssl with maximal security as we understand it and with one compatibility cipher. A run includes some automatic tests (see `test/rspec`).

Using the environment (webserver)
-------

* Get on the virtual machine by running `vagrant ssh webserver`.

* A great way to get to know the VMs is to run through the demo's under [demo/](demo/)
** Basic puppet run [demo/puppet-demo.md](demo/puppet-demo.md)
** Cipher list selection demo [demo/cipherlist-demo.md](demo/cipherlist-demo.md)
** Nginx configuration demo [demo/nginx-config-demo.md](demo/nginx-config-demo.md)
** Vagrant demo [demo/vagrant.md](demo/vagrant.md)


* There is also some provision for manual tests; on the host, port 8080 is forwarded to port 80 on the guest and port 8443 to 443 for webserver. Hence the `http://localhost:8080` and `https://localhost:8443` base URLs can be used in a browser on the host.
* Until the self-signed CA certificate constructed during `vagrant up webserver` is added to the root certificates, browsers complain about the latter base URL. For testing in your browser, you should (temporarly) add the generated ca certificate in your browser. It can be found at `ca/ca_cert.crt`. To add a root certificate in OS X, follow the instructions in http://support.apple.com/kb/PH7297.



Git gotcha
----------

If you are contributing to this project, here is a git nuisance that you need to know about:
the files `ca/serial` and `ca/index.txt` need to exist when running `vagrant up xxx`.
So we put them in the git repository.
But they are changed each time `puppet apply`, and hence `vagrant up`, is run.
Since it is not desirable to check these files in with the new content, you should run 

	git update-index --assume-unchanged ca/index.txt
	git update-index --assume-unchanged ca/serial

secure-webserver
================

Installation scripts to set up a secure web server.
Installation scripts are provided as Puppet modules. There is also a Vagrantfile so that you can use vagrant while you are tweaking the installation.

Prerequisites
-------------

+ Vagrant
+ VirtualBox

Development
-----------

If you are contributing to this project, here is a git nuisance that you need to know about:
the files ca/serial and ca/index.txt need to exist when running vagrant up.
So we put them in the git repository.
But they are changed each time puppet apply, and hence vagrant up, is run.
Since it is not desirable to check these files in with the new content, you should run 

	git update-index --assume-unchanged ca/index.txt
	git update-index --assume-unchanged ca/serial

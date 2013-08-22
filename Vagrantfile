# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  
  config.vm.define :prepuppet do |server|
      # Every Vagrant virtual environment requires a box to build off of.
      server.vm.box = "Ubuntu-12.04.2-64bit-nocm"


  	  # The url from where the 'config.vm.box' box will be fetched if it
  	  # doesn't already exist on the user's system.
  	  server.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box"

      server.vm.hostname = "ubuntu-12-prepuppet"
        
      # Create a forwarded port mapping which allows access to a specific port
	  # within the machine from a port on the host machine. In the example below,
	  # accessing "localhost:8080" will access port 80 on the guest machine.
	  server.vm.network :forwarded_port, guest: 80, host: 9080
	  server.vm.network :forwarded_port, guest: 443, host: 9443
        
      server.vm.provision :shell do |s|
		s.path = 'production/bootstrap.sh'
		s.args = '/vagrant/production'
  	  end
      
      server.vm.provision :shell, :path => "production/prepare-certificate-request.sh"
	  server.vm.provision :shell, :path => "ca/become-ca.sh"
	  server.vm.provision :shell, :inline => "cd /vagrant/ca; ./sign-crt.sh"
  end

  config.vm.define :webserver do |server|
      # Every Vagrant virtual environment requires a box to build off of.
      server.vm.box = "Ubuntu-12.04.2-64bit-nocm"


  	  # The url from where the 'config.vm.box' box will be fetched if it
  	  # doesn't already exist on the user's system.
  	  server.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box"

  
      server.vm.hostname = "ubuntu-12"
      
      # Create a forwarded port mapping which allows access to a specific port
	  # within the machine from a port on the host machine. In the example below,
	  # accessing "localhost:8080" will access port 80 on the guest machine.
	  server.vm.network :forwarded_port, guest: 80, host: 8080
	  server.vm.network :forwarded_port, guest: 443, host: 8443
      
      server.vm.provision :shell do |s|
		s.path = 'production/bootstrap.sh'
		s.args = '/vagrant/production'
  	  end
      
      server.vm.provision :shell, :path => "production/prepare-certificate-request.sh"
	  server.vm.provision :shell, :path => "ca/become-ca.sh"
	  server.vm.provision :shell, :inline => "cd /vagrant/ca; ./sign-crt.sh"

	  server.vm.provision :puppet do |puppet|
		 puppet.module_path = ["production/modules","test/modules"]
		 puppet.manifests_path = "test/manifests"
		 puppet.manifest_file  = "site.pp"
	  end

	  server.vm.provision :shell do |s|
			s.path = "sanity-test.sh"
			s.args = "/vagrant/test"
	  end
      
  end

  config.vm.define :centos do |server|
      # Every Vagrant virtual environment requires a box to build off of.
      server.vm.box = "Centos-64-x64-vbox4210-nocm"

  	  # The url from where the 'config.vm.box' box will be fetched if it
  	  # doesn't already exist on the user's system.
  	  server.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box"

  
      server.vm.hostname = "centos"
      
      # Create a forwarded port mapping which allows access to a specific port
	  # within the machine from a port on the host machine. In the example below,
	  # accessing "localhost:8080" will access port 80 on the guest machine.
	  server.vm.network :forwarded_port, guest: 80, host: 7080
	  server.vm.network :forwarded_port, guest: 443, host: 7443
      
  end

  config.vm.define :debian do |server|
      # Every Vagrant virtual environment requires a box to build off of.
      server.vm.box = "Debian-70rc1-x64-vbox4210-nocm"

  	  # The url from where the 'config.vm.box' box will be fetched if it
  	  # doesn't already exist on the user's system.
  	  server.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210-nocm.box"

  
      server.vm.hostname = "debian"
      
      # Create a forwarded port mapping which allows access to a specific port
	  # within the machine from a port on the host machine. In the example below,
	  # accessing "localhost:8080" will access port 80 on the guest machine.
	  server.vm.network :forwarded_port, guest: 80, host: 6080
	  server.vm.network :forwarded_port, guest: 443, host: 6443
      
  end

end

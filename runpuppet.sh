PUPPET_SCRIPTS=/vagrant/production
sudo puppet apply $PUPPET_SCRIPTS/manifests/site.pp --modulepath $PUPPET_SCRIPTS/modules/:/home/vagrant/.puppet/modules:/usr/share/puppet/modules:/etc/puppet/modules/

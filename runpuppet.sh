#!/bin/bash  

PUPPET_PROD=$(dirname $0)/production
PUPPET_TEST=$(dirname $0)/test
sudo puppet apply $PUPPET_TEST/manifests/site.pp --modulepath  $PUPPET_TEST/modules/:$PUPPET_PROD/modules/:/home/vagrant/.puppet/modules:/etc/puppet/modules/

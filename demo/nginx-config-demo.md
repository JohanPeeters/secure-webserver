Demo: Demonstrating DevOps to ensure a safe nginx configuration
=============================

Nginx configuration
--------

For SSL stripping:

`add_header Strict-Transport-Security max-age=31536000;`

For ordering of ciphers (compatibility):

`ssl_prefer_server_ciphers on;`

For disabling gzip (temporary fix for BREACH)

`gzip on;`


Steps to perform demo:

- Show parameters in `/vagrant/production/modules/nginx/templates/nginx.conf.erb`
- Change configuration file
   + `../runpuppet.sh`
   + `rspec --format documentation spec/nginx_config.rb`
   + Tests fail
- Restore configuration file
   + `../runpuppet.sh`
   + `rspec --format documentation spec/nginx_config.rb`
   + Tests succeed


CRIME and Insecure renegotiation
------

More difficult to demonstrate, no failing tests. 

Testable with:

	`openssl s_client -port 443 -CApath /etc/ssl/certs`








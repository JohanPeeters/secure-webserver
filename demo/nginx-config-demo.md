Demo: Demonstrating DevOps to ensure a safe nginx configuration
=============================

SSL stripping
------
The solution is using a web security policy that obligates HTTPS, called HTTP Strict Transport Security (HSTS). This security policy
status that user agents complying should do the following:
- Automatically turn any insecure links referencing the web application into secure links. (For instance, http://example.com/some/page/ will be modified to https://example.com/some/page/ before accessing the server.)
- If the security of the connection cannot be ensured (e.g. the server's TLS certificate is self-signed), show an error message and do not allow the user to access the web application.


This policy is activated on nginx by setting an extra header in the configuration. 

`add_header Strict-Transport-Security max-age=31536000;`

This header states that future requests to the domain for the next year use only HTTPS. 


- Disable header, see test failing.
    + remove `add_header Strict-Transport-Security max-age=31536000;` in `/vagrant/production/modules/nginx/templates/nginx.conf.erb`
    + `../runpuppet.sh`
    + `rspec --format documentation spec/nginx_config.rb`
    + The test for HSTS should fail


- Enable header, see test succeed
    + Add `add_header Strict-Transport-Security max-age=31536000;` in `/vagrant/production/modules/nginx/templates/nginx.conf.erb`
    + `../runpuppet.sh`
    + `rspec --format documentation spec/nginx_config.rb`
    + The test for HSTS succeeds

Ordering of ciphers for compatibility
------

Most browsers (at least Apache and Nginx) have an option to prefer the order of ciphers of the server 
over the order given by the client. For nginx the option is:


- Disable option, see test failing.
    + remove `ssl_prefer_server_ciphers on;` in `/vagrant/production/modules/nginx/templates/nginx.conf.erb`
    + `../runpuppet.sh`
    + `rspec --format documentation spec/nginx_config.rb`
    + The test for order should fail


- Enable header, see test succeed
    + Add `ssl_prefer_server_ciphers on;` in `/vagrant/production/modules/nginx/templates/nginx.conf.erb`
    + `../runpuppet.sh`
    + `rspec --format documentation spec/nginx_config.rb`
    + The test succeeds

BREACH
------

- Enable gzip, see test failing.
    + Enable `gzip on;` in `/vagrant/production/modules/nginx/templates/nginx.conf.erb`
    + `../runpuppet.sh`
    + `rspec --format documentation spec/nginx_config.rb`
    + The test for BREACH should fail


- Disable gzip, see test succeed
    + Disable `gzip off;` in `/vagrant/production/modules/nginx/templates/nginx.conf.erb`
    + `../runpuppet.sh`
    + `rspec --format documentation spec/nginx_config.rb`
    + The test for BREACH succeeds

CRIME and Insecure renegotiation
------

More difficult to demonstrate, no failing tests. 

Testable with:

	`openssl s_client -port 443 -CApath /etc/ssl/certs`








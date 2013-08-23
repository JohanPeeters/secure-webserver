Demo: cipher list
===================

Preperation: First run the [puppet demo](puppet-demo.md), or bring up the virtual machine:

```bash
vagrant up webserver
vagrant ssh webserver
clear
```

Demo steps:

- show vanilla cipher list as configured after puppet run

- run ciphersuite test

```bash
cd /vagrant/test
rspec --format documentation spec/ciphersuites.rb
```
- introduction to cipher lists (show modules/nginx/manifests/init.pp)
    + the way to communicate to openssl which ciphers to select and which to avoid - openssl converts this into a cipher preference list
    + also used by Apache and Nginx
    + concatenation of cipher strings
    + a cipher string can be 
        * a cipher suite name, e.g. ECDHE-RSA-AES256-SHA
        * a specification of a list of cipher suites, e.g. RC4, kRSA
        * a modified cipher suite name or spec: !, - , +
    + we built the cipher list 'attack-by-attack'. Starting point - all fail.
        * edit `$cipher_string` in `/vagrant/production/modules/nginx/templates/server.conf.erb` to select "ALL:COMPLEMENTPFALL"
        * `cd /vagrant/test`
        * `../runpuppet.sh`
        * `rspec --format documentation spec/ciphersuites.rb`
        All the tests should be failing now.

- testing approach (show cipherenum)
   + find out which ciphers are supported: CIPHERS constant
   + sort them in an accepted and rejected list: check_cipher
   + test whether accepted list includes ciphers with the filter characteristics (show ciphersuites)

-  impervious to beast.
    + `rspec -e BEAST --format documentation spec/ciphersuites.rb`
    + the BEAST test fails
    + edit `$cipher_string` in `/vagrant/production/modules/nginx/templates/server.conf.erb` to select "ALL:$impervious_to_BEAST"
    + `../runpuppet.sh`
    + `rspec -e BEAST --format documentation spec/ciphersuites.rb`
    + unfortunately not a clean spec
    + even worse with Lucky 13

- restore sanity
   + edit `$cipher_string` in `/vagrant/production/modules/nginx/templates/server.conf.erb` to select cipher list without compatibility
   + `../runpuppet.sh`
   + `rspec --format documentation spec/ciphersuites.rb`
   All tests should be passing

- problem: we have removed so many ciphers that no current browser can communicate with our server
   + `ruby -e 'require "./spec/ssl/cipherenum.rb"; Ciphers::print_ciphers'`   
   + only TLS1.2 ciphers left
   + all use ephemeral keys
   + all use AES encryption
   + all use GCM
   + none of the browsers support them
   + so we need to re-add the least worst ciphers
   + is that RC4?
   + edit `$cipher_string` to select cipher list with compatibility
   + `ruby -e 'require "./spec/ssl/cipherenum.rb"; Ciphers::print_ciphers'`   
   + lone RC4 cipher was added 

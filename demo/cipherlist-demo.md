Demo: cipher list
===================

- show vanilla cipher list as configured after puppet run

- run ciphersuite test

```bash
cd /vagrant/test
rspec --format documentation spec/ciphersuites.rb
```

- explain that cipher list was built 'attack-by-attack'. Starting point - all fail.
    + edit `$cipher_string` in `/vagrant/production/modules/nginx/templates/server.conf.erb` to select "ALL:COMPLEMENTPFALL"
    + `../runpuppet.sh`
    + `rspec --format documentation spec/ciphersuites.rb`
    All the tests should be failing now.
 
- authenticate always. Explain that some cipherstrings refer to a set of cipher suites. Explain negation with '-' and '!'.
    + `openssl ciphers -V | tee default_ciphers`
    + `openssl ciphers --cipher ALL | tee all_ciphers`
    + `diff default_ciphers all_ciphers`
    + `openssl ciphers --cipher 'ALL:!aNULL:!eNULL' | tee sane_ciphers`
    + `diff default_ciphers sane_ciphers`
    + edit `$cipher_string` in `/vagrant/production/modules/nginx/templates/server.conf.erb` to select "ALL:$always_authenticated"
    + `../runpuppet.sh`
    + `rspec -e anonymous --format documentation spec/ciphersuites.rb`
    All tests except encryption should be failing.

- concatenation of exclusion: show nginx manifest

- not all properties can be specified cleanly. E.g. no CBC to protect against Lucky 13
   + edit `$cipher_string` in `/vagrant/production/modules/nginx/templates/server.conf.erb`
   + `../runpuppet.sh`
   + `rspec -e Lucky --format documentation spec/ciphersuites.rb`
   All tests except Lucky 13 should be failing.

- restore sanity
   + edit `$cipher_string` in `/vagrant/production/modules/nginx/templates/server.conf.erb`
   + `../runpuppet.sh`
   + `rspec --format documentation spec/ciphersuites.rb`
   All tests should be passing

- add compatibility test

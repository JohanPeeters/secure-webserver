-- Demo 1: Demonstrating puppet --

- Bring up the machine to demonstrate without webserver

` vagrant up prepuppet

- Demonstrate the absence of the correct version of openssl, nginx or any other webserver

` vagrant ssh prepuppet
` wget http://localhost/
` wget https://localhost/
` openssl version
` nginx -v

- Browse through the puppet code

- Run puppet

` cd /vagrant
` ./runpuppet.sh

- Demonstrate the presence of the correct version of openssl, nginx or any other webserver

` wget http://localhost/
` wget https://localhost/
` openssl version
` nginx -v
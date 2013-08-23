Demo: Demonstrating basic puppet
============================

Preperation: Bring up the machine to demonstrate without webserver

```bash
vagrant up prepuppet
vagrant ssh prepuppet
clear
```

- Demonstrate the absence of the correct version of openssl, nginx or any other webserver

```bash
nginx -v
curl http://localhost/
curl https://localhost/
```    

- Browse through the puppet code

- Run puppet

```bash
cd /vagrant
less runpuppet.sh
./runpuppet.sh
```


- Demonstrate the presence of the correct version of openssl, nginx or any other webserver

```bash
curl http://localhost/
curl https://localhost/
nginx -v
sudo service nginx status
```

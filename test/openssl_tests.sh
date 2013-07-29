openssl verify -verbose -purpose sslserver -CAfile /vagrant/ca/ca_cert.pem /etc/ssl/certs/certsigned.crt

openssl s_client -showcerts -CApath /etc/ssl/test/ -connect localhost:443



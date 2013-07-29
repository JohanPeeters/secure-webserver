#! /bin/bash

echo "**becoming a CA"

if [ ! -d /ca ]; then
	mkdir /ca;
fi
cd /ca
openssl genpkey -algorithm rsa \
	-out /vagrant/ca/ca_key.key \
	-pkeyopt rsa_keygen_bits:2048 \
	-pkeyopt rsa_keygen_pubexp:0x100000001 \
	
	
openssl req -new -x509 -days 1825 \
	-subj "/C=BE/L=Brussels/O=TLS Now/CN=TLS Now Root CA/emailAddress=info@tls.now" \
	-key /vagrant/ca/ca_key.key -out /vagrant/ca/ca_cert.crt

#cp ca_cert.crt /etc/ssl/certs/
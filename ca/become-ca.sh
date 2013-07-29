#! /bin/bash

echo "****** becoming a CA ******"

echo "*making ca dir"
if [ ! -d /ca ]; then
	mkdir /ca;
fi
cd /ca

echo "*generating certificate request"
openssl genpkey -algorithm rsa \
	-out /vagrant/ca/ca_key.key \
	-pkeyopt rsa_keygen_bits:2048 \
	-pkeyopt rsa_keygen_pubexp:0x100000001 \
	
echo "*creating a self-signed certificate"	
openssl req -new -x509 -days 1825 \
	-subj "/C=BE/L=Brussels/O=TLS Now/CN=TLS Now Root CA/emailAddress=info@tls.now" \
	-key /vagrant/ca/ca_key.key -out /vagrant/ca/ca_cert.crt

echo "*conversion to PEM for easy use with all kinds of tools"
openssl x509 -in /vagrant/ca/ca_cert.crt -out /vagrant/ca/ca_cert.der -outform DER
openssl x509 -inform der -in /vagrant/ca/ca_cert.der -out /vagrant/ca/ca_cert.pem

echo "*making ca certificate available on test virtual machine"
cp /vagrant/ca/ca_cert.pem /etc/ssl/certs
# c_rehash generates a symbolic link for all pem files in the directory using their hash value
c_rehash /etc/ssl/certs
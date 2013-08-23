#! /bin/bash

echo "****** sign the certificate request ******"

CSR='/etc/ssl/certs/certreq.csr'
if [ -n "$1" ]; then
	CSR="$1";
fi

echo "Regenerating the index, to decouple each certificate generated"
rm index.txt
touch index.txt

echo "Signing the key"
openssl ca -config openssl.cnf \
	-days 365 \
	-in $CSR \
	-keyfile /vagrant/ca/ca_key.key \
	-cert /vagrant/ca/ca_cert.crt \
	-outdir /etc/ssl/certs \
	-out /etc/ssl/certs/certsigned.crt \
	-policy all_optional \
	-md sha256 <<Responses
y
y
Responses

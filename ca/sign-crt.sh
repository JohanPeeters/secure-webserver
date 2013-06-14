#! /bin/bash

CSR='/etc/nginx/cert/certreq.csr'
if [ -n "$1" ]; then
	CSR="$1";
fi

openssl ca -config /etc/ssl/openssl.cnf \
	-in $CSR -keyfile '/ca/ca_key.key' \
	-cert /ca/ca_cert.crt \
	-out /etc/nginx/cert/certsigned.crt

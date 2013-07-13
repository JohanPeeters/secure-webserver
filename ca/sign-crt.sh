#! /bin/bash

CSR='/etc/ssl/certs/certreq.csr'
if [ -n "$1" ]; then
	CSR="$1";
fi

openssl ca -config /etc/ssl/openssl.cnf \
	-in $CSR -keyfile '/ca/ca_key.key' \
	-cert /ca/ca_cert.crt \
	-out /etc/ssl/certs/certsigned.crt

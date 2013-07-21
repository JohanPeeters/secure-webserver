#! /bin/bash

CSR='/etc/ssl/certs/certreq.csr'
if [ -n "$1" ]; then
	CSR="$1";
fi

openssl ca -config openssl.cnf \
	-days 365 \
	-in $CSR \
	-keyfile /ca/ca_key.key \
	-cert /ca/ca_cert.crt \
	-outdir /etc/ssl/certs \
	-out /etc/ssl/certs/certsigned.crt \
	-policy all_optional \
	-md sha1

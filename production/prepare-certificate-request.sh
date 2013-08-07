echo "** Generating private key"

if [ "$1" != "" ]; then
	HOSTNAME="$1"
else
	HOSTNAME=localhost
fi
VALIDITY_PERIOD=365
CERT_LOCATION=/etc/ssl/certs
KEY_LOCATION=/etc/ssl/private

#For securing the key
umask -S u=rw,go=
mkdir -p $KEY_LOCATION
#chown root private/
#chgrp root private/
#chmod go-rw private

openssl genpkey -algorithm rsa \
	-out $KEY_LOCATION/keys.key \
	-pkeyopt rsa_keygen_bits:2048 \
	-pkeyopt rsa_keygen_pubexp:0x100000001

#Setting back the default settings
umask 0002

openssl req -new -subj "/CN=$HOSTNAME/" \
	-days $VALIDITY_PERIOD \
	-key $KEY_LOCATION/keys.key \
	-out $CERT_LOCATION/certreq.csr



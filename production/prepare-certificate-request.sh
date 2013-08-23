echo "****** Generate a private key and a certificate request ******"

if [ "$1" != "" ]; then
	HOSTNAME="$1"
else
	HOSTNAME=localhost
fi

VALIDITY_PERIOD=365
CERT_LOCATION=/etc/ssl/certs
KEY_LOCATION=/etc/ssl/private

echo "*Prepare to generate the key (umask for security)"
umask -S u=rw,go=
mkdir -p $KEY_LOCATION

echo "*Generating a private key"
openssl genpkey -algorithm rsa \
	-out $KEY_LOCATION/keys.key \
	-pkeyopt rsa_keygen_bits:2048 \
	-pkeyopt rsa_keygen_pubexp:0x100000001


umask 0002

echo "*Generating a certificate request"
openssl req -new -subj "/CN=$HOSTNAME/" \
	-days $VALIDITY_PERIOD \
	-key $KEY_LOCATION/keys.key \
	-out $CERT_LOCATION/certreq.csr



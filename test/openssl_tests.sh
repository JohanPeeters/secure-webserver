openssl verify -verbose -purpose sslserver -CAfile /vagrant/ca/ca_cert.pem /etc/ssl/certs/certsigned.crt

openssl s_client -showcerts -CApath /etc/ssl/test/ -connect localhost:443

sudo openssl s_server -accept 7777 -cert /etc/ssl/certs/certsigned.crt -key /etc/ssl/private/ke.key -cipher 'ALL:!ADH'


Ciphers not appearing in the IANA list
     0x07,0x00,0xC0 - DES-CBC3-MD5            SSLv2 Kx=RSA      Au=RSA  Enc=3DES(168) Mac=MD5
    0x05,0x00,0x80 - IDEA-CBC-MD5            SSLv2 Kx=RSA      Au=RSA  Enc=IDEA(128) Mac=MD5
     0x03,0x00,0x80 - RC2-CBC-MD5             SSLv2 Kx=RSA      Au=RSA  Enc=RC2(128)  Mac=MD5
     0x01,0x00,0x80 - RC4-MD5                 SSLv2 Kx=RSA      Au=RSA  Enc=RC4(128)  Mac=MD5
     0x06,0x00,0x40 - DES-CBC-MD5             SSLv2 Kx=RSA      Au=RSA  Enc=DES(56)   Mac=MD5
     0x04,0x00,0x80 - EXP-RC2-CBC-MD5         SSLv2 Kx=RSA(512) Au=RSA  Enc=RC2(40)   Mac=MD5  export
     0x02,0x00,0x80 - EXP-RC4-MD5             SSLv2 Kx=RSA(512) Au=RSA  Enc=RC4(40)   Mac=MD5  export


http://www.net-security.org/article.php?id=1638

SSLCipherSuite RC4-SHA:HIGH:!ADH
SSLCipherSuite ECDHE-RSA-AES256-SHA384:AES256-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM



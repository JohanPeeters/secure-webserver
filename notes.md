test voor forward Secrecy
test voor RC4
test voor Beast
test voor Crime/Breach
test voor insecure renegotiating

verify list of cipher suites to support

Prioritize for RC4 (mitigate beast)
verify ordering of ciphers and protocols

------ After start of presentation / demo

investigate difference between test certificate and production certificate

Install on "production" server
Validate with SSL labs tool

TLS/SSL-only sites (Thomas)

------ less essential ----

update TLS/ciphers/mode/hashes according to presentation of Thomas

performance of ssl, mainly to persist ssl connections (verify with security advice nginx + Performance optimisations SSLlabs)

use tls.now as hostname + www.tls.now

Forward Secrecy (SSL Labs)

CSP in web configuratie (Johan?)

Add support for Ruby sslv2

OCSP stapling

Use puppet resources for instanciating new servers in the nginx conf

cleanup spec code to do https request

nginx error handling -- nginx-default?

verify hostnames between nginx and certificate + virtual hosts (see presentation Thomas, page 13, slide 26)

investigate if existing nginx module can be used

stdin: is not a tty

------- non prioritized ----



MD5 collision ?
Extended validation?

Testen met backtrack






































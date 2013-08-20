class nginx ($version, $host){
 
	$always_encrypted = "!eNULL:!NULL"
	$always_authenticated = "!ADH:!aNULL"
	$not_DES = "!DES"
	$enc_key_at_least_128b = "!EXPORT:!LOW"
	$impervious_to_BEAST = "-ECDHE-RSA-AES256-SHA:-DHE-RSA-AES256-SHA:-DHE-RSA-CAMELLIA256-SHA:-AECDH-AES256-SHA:-ADH-AES256-SHA:-ADH-CAMELLIA256-SHA:-AES256-SHA:-CAMELLIA256-SHA:-ECDHE-RSA-DES-CBC3-SHA:-EDH-RSA-DES-CBC3-SHA:-AECDH-DES-CBC3-SHA:-ADH-DES-CBC3-SHA:-DES-CBC3-SHA:-ECDHE-RSA-AES128-SHA:-DHE-RSA-AES128-SHA:-DHE-RSA-SEED-SHA:-DHE-RSA-CAMELLIA128-SHA:-AECDH-AES128-SHA:-ADH-AES128-SHA:-ADH-SEED-SHA:-ADH-CAMELLIA128-SHA:-AES128-SHA:-SEED-SHA:-CAMELLIA128-SHA:-EDH-RSA-DES-CBC-SHA:-ADH-DES-CBC-SHA:-DES-CBC-SHA:-EXP-DES-CBC-SHA:-EXP-RC2-CBC-MD5"
	$not_RC4 = "-RC4"
	$forward_secrecy = "-kRSA"
	$impervious_to_Lucky_13_no_CBC = "-DHE-RSA-AES256-SHA:-DHE-RSA-CAMELLIA256-SHA:-AES256-SHA:-CAMELLIA256-SHA:-ECDHE-RSA-DES-CBC3-SHA:-EDH-RSA-DES-CBC3-SHA:-DES-CBC3-SHA:-ECDHE-RSA-AES128-SHA:-DHE-RSA-AES128-SHA:-DHE-RSA-SEED-SHA:-DHE-RSA-CAMELLIA128-SHA:-AES128-SHA:-SEED-SHA:-CAMELLIA128-SHA:-ECDHE-RSA-AES256-SHA:-DHE-RSA-AES256-SHA:-DHE-RSA-CAMELLIA256-SHA:-AES256-SHA:-CAMELLIA256-SHA:-ECDHE-RSA-DES-CBC3-SHA:-EDH-RSA-DES-CBC3-SHA:-DES-CBC3-SHA:-ECDHE-RSA-AES128-SHA:-DHE-RSA-AES128-SHA:-DHE-RSA-SEED-SHA:-DHE-RSA-CAMELLIA128-SHA:-AES128-SHA:-SEED-SHA:-CAMELLIA128-SHA:-ECDHE-RSA-AES256-SHA:-DHE-RSA-AES256-SHA:-DHE-RSA-CAMELLIA256-SHA:-AES256-SHA:-CAMELLIA256-SHA:-ECDHE-RSA-DES-CBC3-SHA:-EDH-RSA-DES-CBC3-SHA:-DES-CBC3-SHA:-ECDHE-RSA-AES128-SHA:-DHE-RSA-AES128-SHA:-DHE-RSA-SEED-SHA:-DHE-RSA-CAMELLIA128-SHA:-AES128-SHA:-SEED-SHA:-CAMELLIA128-SHA:-ECDHE-RSA-AES256-SHA:-DHE-RSA-AES256-SHA:-DHE-RSA-CAMELLIA256-SHA:-AES256-SHA:-CAMELLIA256-SHA:-ECDHE-RSA-DES-CBC3-SHA:-EDH-RSA-DES-CBC3-SHA:-DES-CBC3-SHA:-ECDHE-RSA-AES128-SHA:-DHE-RSA-AES128-SHA:-DHE-RSA-SEED-SHA:-DHE-RSA-CAMELLIA128-SHA:-AES128-SHA:-SEED-SHA:-CAMELLIA128-SHA:-ECDHE-RSA-AES256-SHA384:-ECDHE-ECDSA-AES256-SHA384:-ECDHE-RSA-AES256-SHA:-ECDHE-ECDSA-AES256-SHA:-SRP-DSS-AES-256-CBC-SHA:-SRP-RSA-AES-256-CBC-SHA:-DHE-RSA-AES256-SHA256:-DHE-DSS-AES256-SHA256:-DHE-RSA-AES256-SHA:-DHE-DSS-AES256-SHA:-DHE-RSA-CAMELLIA256-SHA:-DHE-DSS-CAMELLIA256-SHA:-ECDH-RSA-AES256-SHA384:-ECDH-ECDSA-AES256-SHA384:-ECDH-RSA-AES256-SHA:-ECDH-ECDSA-AES256-SHA:-AES256-SHA256:-AES256-SHA:-CAMELLIA256-SHA:-PSK-AES256-CBC-SHA:-ECDHE-RSA-DES-CBC3-SHA:-ECDHE-ECDSA-DES-CBC3-SHA:-SRP-DSS-3DES-EDE-CBC-SHA:-SRP-RSA-3DES-EDE-CBC-SHA:-EDH-RSA-DES-CBC3-SHA:-EDH-DSS-DES-CBC3-SHA:-ECDH-RSA-DES-CBC3-SHA:-ECDH-ECDSA-DES-CBC3-SHA:-DES-CBC3-SHA:-PSK-3DES-EDE-CBC-SHA:-ECDHE-RSA-AES128-SHA256:-ECDHE-ECDSA-AES128-SHA256:-ECDHE-RSA-AES128-SHA:-ECDHE-ECDSA-AES128-SHA:-SRP-DSS-AES-128-CBC-SHA:-SRP-RSA-AES-128-CBC-SHA:-DHE-RSA-AES128-SHA256:-DHE-DSS-AES128-SHA256:-DHE-RSA-AES128-SHA:-DHE-DSS-AES128-SHA:-DHE-RSA-SEED-SHA:-DHE-DSS-SEED-SHA:-DHE-RSA-CAMELLIA128-SHA:-DHE-DSS-CAMELLIA128-SHA:-ECDH-RSA-AES128-SHA256:-ECDH-ECDSA-AES128-SHA256:-ECDH-RSA-AES128-SHA:-ECDH-ECDSA-AES128-SHA:-AES128-SHA256:-AES128-SHA:-SEED-SHA:-CAMELLIA128-SHA:-IDEA-CBC-SHA:-PSK-AES128-CBC-SHA:-EDH-RSA-DES-CBC-SHA:-EDH-DSS-DES-CBC-SHA:-DES-CBC-SHA:-EXP-EDH-RSA-DES-CBC-SHA:-EXP-EDH-DSS-DES-CBC-SHA:-EXP-DES-CBC-SHA:-EXP-RC2-CBC-MD5:-AECDH-AES256-SHA:-ADH-AES256-SHA256:-ADH-AES256-SHA:-ADH-CAMELLIA256-SHA:-AECDH-DES-CBC3-SHA:-ADH-DES-CBC3-SHA:-AECDH-AES128-SHA:-ADH-AES128-SHA256:-ADH-AES128-SHA:-ADH-SEED-SHA:-ADH-CAMELLIA128-SHA:-ADH-DES-CBC-SHA"
	$fullcompatibility = "ECDHE-RSA-RC4-SHA:DES-CBC3-SHA"
	$compatibility = "ECDHE-RSA-RC4-SHA"

#	$cipher_list = "ALL:$always_encrypted:$always_authenticated:$not_DES:$enc_key_at_least_128b:$impervious_to_BEAST:$not_RC4:$forward_secrecy:$impervious_to_Lucky_13_no_CBC"
	$cipher_list = "ALL:$always_encrypted:$always_authenticated:$not_DES:$enc_key_at_least_128b:$impervious_to_BEAST:$not_RC4:$forward_secrecy:$impervious_to_Lucky_13_no_CBC:$compatibility"
#	$cipher_list = "ALL"
#	$cipher_list = "ALL:COMPLEMENTOFALL"
#	$cipher_list = "ALL:COMPLEMENTOFALL:$always_encrypted"
#	$cipher_list = "ALL:$always_encrypted"
#	$cipher_list = "ALL:$always_authenticated"
#	$cipher_list = "ALL:$not_DES"
#	$cipher_list = "ALL:$enc_key_at_least_128b"
#	$cipher_list = "ALL:$impervious_to_BEAST"
#	$cipher_list = "ALL:$not_RC4"
#	$cipher_list = "ALL:$impervious_to_Lucky_13_no_CBC"
#	$cipher_list = "ALL:$forward_secrecy"


	package {'nginx':
		ensure => $version
	}
	
	file {"/etc/nginx/nginx.conf":
		ensure => present,
		content => template('nginx/nginx.conf.erb'),
		require => Package['nginx'],
		notify => Service['nginx'],
	}
	
	file {"/etc/nginx":
		ensure => directory,
	}
	
	file {"/etc/nginx/sites-available":
		ensure => directory,
	}
	
	file {"/etc/nginx/sites-enabled":
		ensure => directory,
	}
	
	file {'/etc/nginx/sites-enabled/default':
		ensure => absent,
		require => Package['nginx']
	}
	
	file {'/etc/nginx/sites-available/default':
		ensure => absent,
		require => File['/etc/nginx/sites-enabled/default'],
	}
	
	file {"/etc/nginx/sites-available/$host":
		ensure => present,
		content => template('nginx/host.conf.erb'),
		require => Package['nginx'],
		notify => Service['nginx'],
	}
	
	file {"/etc/nginx/sites-enabled/$host.conf":
		ensure => link,
		target => "/etc/nginx/sites-available/$host",
		notify => Service['nginx'],
	}
	
	service {'nginx':
		ensure => running,
		enable => true,
	}
}

class nginx ($version, $host){
 
	$not_DES = "!DES"
	$enc_key_at_least_128b = "!EXPORT:!LOW"
	$impervious_to_Lucky_13 = "!ECDHE-RSA-AES256-SHA:!DHE-RSA-AES256-SHA:!DHE-RSA-CAMELLIA256-SHA:!AES256-SHA:!CAMELLIA256-SHA:!ECDHE-RSA-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!DES-CBC3-SHA:!ECDHE-RSA-AES128-SHA:!DHE-RSA-AES128-SHA:!DHE-RSA-SEED-SHA:!DHE-RSA-CAMELLIA128-SHA:!AES128-SHA:!SEED-SHA:!CAMELLIA128-SHA:!ECDHE-RSA-AES256-SHA:!DHE-RSA-AES256-SHA:!DHE-RSA-CAMELLIA256-SHA:!AES256-SHA:!CAMELLIA256-SHA:!ECDHE-RSA-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!DES-CBC3-SHA:!ECDHE-RSA-AES128-SHA:!DHE-RSA-AES128-SHA:!DHE-RSA-SEED-SHA:!DHE-RSA-CAMELLIA128-SHA:!AES128-SHA:!SEED-SHA:!CAMELLIA128-SHA:!ECDHE-RSA-AES256-SHA:!DHE-RSA-AES256-SHA:!DHE-RSA-CAMELLIA256-SHA:!AES256-SHA:!CAMELLIA256-SHA:!ECDHE-RSA-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!DES-CBC3-SHA:!ECDHE-RSA-AES128-SHA:!DHE-RSA-AES128-SHA:!DHE-RSA-SEED-SHA:!DHE-RSA-CAMELLIA128-SHA:!AES128-SHA:!SEED-SHA:!CAMELLIA128-SHA:!ECDHE-RSA-AES256-SHA:!DHE-RSA-AES256-SHA:!DHE-RSA-CAMELLIA256-SHA:!AES256-SHA:!CAMELLIA256-SHA:!ECDHE-RSA-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!DES-CBC3-SHA:!ECDHE-RSA-AES128-SHA:!DHE-RSA-AES128-SHA:!DHE-RSA-SEED-SHA:!DHE-RSA-CAMELLIA128-SHA:!AES128-SHA:!SEED-SHA:!CAMELLIA128-SHA"
	$cipher_string = "ALL:$not_DES:$enc_key_at_least_128b:$impervious_to_Lucky_13"

	package {'nginx':
		ensure => $version
	}
	file {"/etc/nginx/nginx.conf":
		source  => "puppet:///modules/nginx/nginx.conf",
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

class nginx ($version, $host){
	# in order to install reasonably recent versions of nginx,
	# impervious to recent security advisories,
	# we need to add an apt repository.


	package {'nginx':
		ensure => $version
	}
	
	group { 'www-data' :
		ensure => present,
	}

	user { 'www-data' :
		ensure 		=> present,
		managehome 	=> false,
		gid 		=> 'www-data',
		require 	=> Group['www-data'],
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
		require => Package['nginx']
	}
	file {"/etc/nginx/sites-enabled/$host":
		ensure => link,
		target => "/etc/nginx/sites-available/$host"
	}
	service {'nginx':
		ensure => running,
		enable => true,
		subscribe => File["/etc/nginx/sites-available/$host"],
	}
}

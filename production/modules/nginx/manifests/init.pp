class nginx ($version, $host){
	# in order to install reasonably recent versions of nginx,
	# impervious to recent security advisories,
	# we need to add an apt repository.
 
	package {'nginx':
		ensure => $version
	}
	file {"/etc/nginx/nginx.conf":
		source  => "puppet:///modules/nginx/nginx.conf",
		require => Package['nginx'],
		notify => Service['nginx'],
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

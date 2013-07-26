class httpsdemo {

	file{'/etc/ssl/':
			ensure => directory;
		'/etc/ssl/certs/':
			ensure => directory;
		'/etc/ssl/private/':
			ensure => directory;
		'/var/www/':
			ensure => directory,
			recurse => true,
			source => 'puppet:///modules/httpsdemo/www';
	}

}
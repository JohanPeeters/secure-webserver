node default {

	class{'nginx':
		version => '1.4.2-1~precise',
		host    => 'localhost',
		require => Apt::Source['nginx'],
	}
	
	apt::source { 'nginx':
		location    => 'http://nginx.org/packages/ubuntu/',
		release     => 'precise',
		repos       => 'nginx',
		include_src => false
	}
	
	file{'/etc/ssl/':
			ensure => directory;
		'/etc/ssl/certs/':
			ensure => directory;
		'/etc/ssl/private/':
			ensure => directory;
	}
			
}


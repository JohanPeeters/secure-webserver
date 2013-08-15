node default {

	apt::source { 'nginx':
		location    => 'http://nginx.org/packages/ubuntu/',
		release     => 'precise',
		repos       => 'nginx',
		include_src => false
	}

	class{'nginx':
		version => '1.4.2-1~precise',
		host    => 'localhost',
		require => Apt::Source['nginx'],
	}
	
	include httpsdemo
	
			
}


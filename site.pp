node 'ubuntu-12' {
	class{'nginx':
		version => '1.4.1-1~precise',
		host    => 'localhost',
		require => Apt::Source['nginx'],
	}
	apt::source { 'nginx':
		location                => 'http://nginx.org/packages/ubuntu/',
		release               => 'precise',
		repos               => 'nginx',
		#required_packages => 'debian-keyring debian-archive-keyring',
		#key                    => '55BE302B',
		#key_server           => 'subkeys.pgp.net',
		#pin                => '-10',
		include_src      => false
	}
}


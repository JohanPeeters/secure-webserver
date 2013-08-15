Demo: Demonstrating DevOps to ensure a safe nginx configuration
=============================

Problems covered:
- CRIME --> Disable TLS compression
- BREACH --> No practical solution, e.g. disable gzip compression?
- Insecure renegotiation --> Only allow secure renegotiation
- SSL stripping --> HSTS



disabled from nginx version 1.2.2. Updating fixes the Problems
- Insecure renegotiation --> standard disabled in nginx (not sure since which version)

```puppet
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
```



- HSTS




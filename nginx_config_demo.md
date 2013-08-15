Demo: Demonstrating DevOps to ensure a safe nginx configuration
=============================

Problems covered:
- CRIME --> Disable TLS compression
- SSL stripping --> HSTS
- BREACH --> No practical solution, e.g. disable gzip compression?
- Insecure renegotiation --> Only allow secure renegotiation


Demonstrate tests:

`rspec test/spec/nginx_config.rb`

CRIME
-----

- Easy, install nginx. TLS compression is disabled by default.

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

- Tested with:

`openssl s_client -port 443 -CApath /etc/ssl/certs`


SSL stripping
------

- The solution is using a web security policy that obligates HTTPS, called HTTP Strict Transport Security (HSTS).

- This policy is activated on nginx by setting an extra header in the configuration. 

`add_header Strict-Transport-Security max-age=31536000;`

This header states that future requests to the domain for the next year use only HTTPS. 
User agents complying should do the following:
- Automatically turn any insecure links referencing the web application into secure links. (For instance, http://example.com/some/page/ will be modified to https://example.com/some/page/ before accessing the server.)
- If the security of the connection cannot be ensured (e.g. the server's TLS certificate is self-signed), show an error message and do not allow the user to access the web application.






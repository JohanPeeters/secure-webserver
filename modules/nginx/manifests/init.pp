class nginx ($host = 'secappdev.org'){
  package {'nginx':
    ensure => '1.2.1-2.2',
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

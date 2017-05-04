node 'stingray' {
  host { 'stingray':
    ip      => '10.0.0.20',
    before  => Class['stingray'],
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
    before  => Class['stingray'],
  }

  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
    before  => Class['stingray'],
  }

  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
    before  => Class['stingray'],
  }

  firewall { '003 allow ssh access':
    port   => 22,
    proto  => 'tcp',
    action => 'accept',
    before  => Class['stingray'],
  }

  firewall { '004 allow http and https access':
    port   => [80, 443],
    proto  => 'tcp',
    action => 'accept',
    before  => Class['stingray'],
  }

  firewall { '100 allow Stingray Admin UI access':
    port   => 9090,
    proto  => 'tcp',
    action => 'accept',
    before  => Class['stingray'],
  }

  firewall { '101 allow Stingray unicast access':
    port   => 9090,
    proto  => 'udp',
    action => 'accept',
    before  => Class['stingray'],
  }

  firewall { '102 allow Stingray rest api access':
    port   => 9070,
    proto  => 'tcp',
    action => 'accept',
    before  => Class['stingray'],
  }

  firewall { '103 allow Stingray application access':
    port   => 9080,
    proto  => 'tcp',
    action => 'accept',
    before  => Class['stingray'],
  }

  firewall { '104 allow Stingray application access':
    port   => 9080,
    proto  => 'udp',
    action => 'accept',
    before  => Class['stingray'],
  }

  firewall { '105 allow access to custom site.':
    port   => 8000,
    proto  => 'tcp',
    action => 'accept',
    before  => Class['stingray'],
  }

  # install java
  package { 'jdk':
    ensure => installed,
    name   => 'java-1.7.0-openjdk',
  }

  class {'stingray':
    accept_license => 'accept',
    version        => '9.2',
    require        => Package['jdk'],
  }

  stingray::settings { 'My Settings':
    controlallow => 'all',
    require      => Class['stingray'],
  }

  stingray::new_cluster{'new_cluster':
    require        => Class['stingray'],
  }

  stingray::trafficipgroup { 'FirstSite_TrafficIP':
    ipaddresses => ['10.0.1.100', ],
    machines    => 'stingray',
    enabled     => 'yes',
    require     => Class['stingray'],
  }

  stingray::pool { 'FirstSite-Pool':
    nodes       => ['10.0.0.21:80', '10.0.0.22:80' ],
    algorithm   => 'perceptive',
    persistence => 'FirstSite_Persistence',
    monitors    => 'FirstSite_HTTP_Monitor',
    require     => Class['stingray'],
  }

  stingray::virtual_server { 'FirstSite_Virtual_Server':
    address  => '!FirstSite_TrafficIP',
    protocol => 'HTTP',
    pool     => 'FirstSite-Pool',
    port     => 80,
    enabled  => 'yes',
    require  => Class['stingray'],
  }

  stingray::persistence{'FirstSite_Persistence':
    type     => 'Transparent session affinity',
    require  => Class['stingray'],
  }

  stingray::monitor { 'FirstSite_HTTP_Monitor':
    type         => 'HTTP',
    status_regex => '^[234][0-9][0-9]$',
    path         => '/',
    require      => Class['stingray'],
  }
}

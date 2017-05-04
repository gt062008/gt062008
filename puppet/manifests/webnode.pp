node /^webnode-\d+$/ {
  package { httpd: ensure => installed; }
  package { php: ensure => installed; }

  service {'httpd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [ Package['httpd'], ]
  }


  # Default firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }
  firewall { '003 allow ssh access':
    port   => 22,
    proto  => tcp,
    action => accept,
  }
  firewall { '004 allow http access':
    port   => 80,
    proto  => tcp,
    action => accept,
  }

}
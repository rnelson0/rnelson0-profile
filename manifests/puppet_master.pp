# == Class: profile::puppet_master
#
# Puppet Master profile
#
# === Parameters
#
# None
#
# === Variables
#
# None
#
# === Examples
#
#  include profile::puppet_master
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::puppet_master {
  class { '::puppet::master':
    storeconfigs => true,
    environments => 'directory',
  }

  firewall { '100 allow agent checkins':
    dport  => 8140,
    proto  => tcp,
    action => accept,
  }

  firewall { '110 sinatra web hook':
    dport  => 80,
    proto  => tcp,
    action => accept,
  }
}

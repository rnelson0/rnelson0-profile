# == Class: profile::sshgw
#
# SSH VPN Tunnel
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::sshgw {
  # Host file entries
  $sshvpn_hosts = hiera_hash('sshvpn_hosts', undef)
  if ($sshvpn_hosts) {
    create_resources('host', $sshvpn_hosts)
  }

  # SSH directory and keys
  file { '/root/.ssh':
    ensure   => 'directory',
    mode     => '0700',
  } -> 
  file { '/root/.ssh/id_rsa':
    ensure => file,
    source => "puppet:///modules/home_config/${puppet_role}/id_rsa",
  } ->
  file { '/root/.ssh/id-rsa.pub':
    ensure => file,
    source => "puppet:///modules/home_config/${puppet_role}/id_rsa.pub",
  }

  package { 'sshvpn':
    ensure => latest,
  }
}

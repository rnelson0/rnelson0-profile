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
# Copyright 2015 Rob Nelson
#
class profile::sshgw (
  $sshvpnversion = $profile::params::sshvpnversion,
) inherits profile::params {
  # Host file entries
  $sshvpn_hosts = hiera_hash('sshvpn_hosts', undef)
  if ($sshvpn_hosts) {
    create_resources('host', $sshvpn_hosts)
  }

  # SSH directory and keys
  file { '/root/.ssh':
    ensure => 'directory',
    mode   => '0700',
  } ->
  file { '/root/.ssh/id_rsa':
    ensure => file,
    source => "puppet:///modules/home_config/${::puppet_role}/id_rsa",
    mode   => '0600',
  } ->
  file { '/root/.ssh/id-rsa.pub':
    ensure => file,
    source => "puppet:///modules/home_config/${::puppet_role}/id_rsa.pub",
  } ->
  file { '/root/.ssh/config':
    ensure => file,
    source => "puppet:///modules/home_config/${::puppet_role}/ssh_config",
  } ->
  package { 'sshvpn':
    ensure => $sshvpnversion,
  }

  # Firewall rules
  firewall { '100 eth0 accept':
    iniface => 'eth0',
    proto   => 'all',
    action  => 'accept',
  }
  firewall { '110 forward tun0 established':
    chain    => 'FORWARD',
    iniface  => 'tun0',
    outiface => 'eth0',
    state    => ['RELATED', 'ESTABLISHED',],
    proto    => 'all',
    action   => 'accept',
  }
  firewall { '115 forward eth0 to tun0 accept':
    chain    => 'FORWARD',
    iniface  => 'eth0',
    outiface => 'tun0',
    proto    => 'all',
    action   => 'accept',
  }
  firewall { '120 forward eth0 to eth0 accept':
    chain    => 'FORWARD',
    iniface  => 'eth0',
    outiface => 'eth0',
    proto    => 'all',
    action   => 'accept',
  }
  firewall { '130 NAT masquerade':
    chain    => 'POSTROUTING',
    outiface => 'tun0',
    jump     => 'MASQUERADE',
    proto    => 'all',
    table    => 'nat',
  }
}

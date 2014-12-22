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

  # Named package and configs
  include bind
  $bind_server_confs = hiera_hash('sshgw::bind_server_confs', undef)
  if ($bind_server_confs) {
    create_resources('bind::server::conf', $bind_server_confs)
  }
  $bind_server_files = hiera_hash('sshgw::bind_server_files', undef)
  if ($bind_server_files) {
    create_resources('bind::server::file', $bind_server_files)
  }

  # DHCP service and host reservations
  include dhcp::server
  $dhcp_server_subnets = hiera_hash('sshgw::dhcp_server_subnets', undef)
  if ($dhcp_server_subnets) {
    create_resources('dhcp::server::subnet', $dhcp_server_subnets)
  }

  $dhcp_server_hosts = hiera_hash('sshgw::dhcp_server_hosts', undef)
  if ($dhcp_server_hosts) {
    create_resources('dhcp::server::host', $dhcp_server_hosts)
  }
}

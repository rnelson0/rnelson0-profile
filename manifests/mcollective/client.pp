# == Class: profile::mcollective::client
#
# Profile for an mcollective client node
# Client in context indicates a node where 'mco' can be run.
# It must be able to communicate with the middleware_host.
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::mcollective::client {
  class { '::mcollective':
    client             => true,
    middleware_hosts   => [ 'puppet.nelson.va' ],
    middleware_ssl     => true,
    securityprovider   => 'ssl',
    ssl_client_certs   => 'puppet:///modules/site_mcollective/client_certs',
    ssl_ca_cert        => 'puppet:///modules/site_mcollective/certs/ca.pem',
    ssl_server_public  => 'puppet:///modules/site_mcollective/certs/puppet.nelson.va.pem',
    ssl_server_private => 'puppet:///modules/site_mcollective/private_keys/puppet.nelson.va.pem',
  }

  $plugins = [ 'service', 'package', 'puppet']
  mcollective::plugin { $plugins:
    package => true,
  }

  user { 'root':
    ensure => present,
  } ->
  mcollective::user { 'root':
    homedir     => '/root',
    certificate => 'puppet:///modules/site_mcollective/client_certs/root.pem',
    private_key => 'puppet:///modules/site_mcollective/private_keys/root.pem',
  }
}

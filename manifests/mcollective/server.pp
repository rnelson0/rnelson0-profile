# == Class: profile::mcollective::server
#
# Profile for an mcollective server node.
# Server in this case indicates a node that is managed by mcollective.
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::mcollective::server {
  class { '::mcollective':
    middleware_hosts   => [ 'puppet.nelson.va' ],
    middleware_ssl     => true,
    securityprovider   => 'ssl',
    ssl_client_certs   => 'puppet:///modules/site_mcollective/client_certs',
    ssl_ca_cert        => 'puppet:///modules/site_mcollective/certs/ca.pem',
    ssl_server_public  => 'puppet:///modules/site_mcollective/certs/puppet.nelson.va.pem',
    ssl_server_private => 'puppet:///modules/site_mcollective/private_keys/puppet.nelson.va.pem',
  }
}

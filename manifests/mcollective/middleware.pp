# == Class: profile::mcollective::middleware
#
# Role for an mcollective middleware node.
# Middleware nodes communicate between the mco client and the managed servers.
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
# include profile::mcollective::middleware
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::mcollective::middleware {
  class { '::mcollective':
    middleware         => true,
    middleware_hosts   => [ 'puppet.nelson.va' ],
    middleware_ssl     => true,
    securityprovider   => 'ssl',
    ssl_client_certs   => 'puppet:///modules/site_mcollective/client_certs',
    ssl_ca_cert        => 'puppet:///modules/site_mcollective/certs/ca.pem',
    ssl_server_public  => 'puppet:///modules/site_mcollective/certs/puppet.nelson.va.pem',
    ssl_server_private => 'puppet:///modules/site_mcollective/private_keys/puppet.nelson.va.pem',
  }
}

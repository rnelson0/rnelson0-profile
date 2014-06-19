# == Class: profile::mcollective::users
#
# Define common users for mcollective and populate their certs
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
# include profile::mcollective::users
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::mcollective::users {
  user { 'root':
    ensure => present,
  } ->
  mcollective::user { 'root':
    homedir     => '/root',
    certificate => 'puppet:///modules/site_mcollective/client_certs/root.pem',
    private_key => 'puppet:///modules/site_mcollective/private_keys/root.pem',
  }
}

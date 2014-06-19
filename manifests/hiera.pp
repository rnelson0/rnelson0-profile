# == Class: profile::hiera
#
# Hiera profile
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
#  include profile::hiera
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::hiera {
  package { ['hiera', 'hiera-puppet']:
    ensure => present,
  }
}

# == Class: profile::build
#
# build profile
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
#  include profile::build
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::build {
  package {['ruby-devel', 'gcc', 'rpm-build']:
    ensure => present,
  }
  package {'fpm':
    ensure   => present,
    provider => gem,
    require  => Package['ruby-devel'],
  }
  package {'rspec-puppet':
    ensure   => present,
    provider => gem,
  }
}

# == Class: profile::puppetdb
#
# PuppetDB profile
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
#  include profile::puppetdb
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::puppetdb {
  include ::puppetdb
  include ::puppetdb::master::config
}

# == Class: profile::yumrepo
#
# Create a yum-compatible repo
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
#  include profile::yumrepo
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::yumrepo {
  class {'::profile::apache': }

  apache::vhost {'yum.nelson.va':
    docroot    => '/var/www/html/puppetrepo',
  }
}

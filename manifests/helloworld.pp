# == Class: profile::helloworld
#
# The helloworld application profile
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::helloworld {
  class {'::profile::apache': }
  class {'::apache::mod::php': }

  apache::vhost {'helloworld.nelson.va':
    docroot => '/var/www/html',
  }

  Yumrepo['el-6.5'] -> Package <| |>

  package {'helloworld':
    ensure  => 'present',
  }
}

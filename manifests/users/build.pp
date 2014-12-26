# == Class: profile::users::build
#
# Profile for users in the build group
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class profile::users::build {
  # crypted form of 'password'
  $adminpassword = '$6$TV63aMpF$7ZUXhaJKJSCIjJCDftQJnAtymSuYElpkCPTsBirG9nxQr1ZtM6apF6U3sJYlzLssqziv0rqX.MXWnleSvKBR0.'

  ::profile::users::local_user { 'rnelson0':
    id       => 'rnelson0',
    state    => 'present',
    comment  => 'Rob Nelson',
    groups   => ['wheel'],
    password => $adminpassword,
  }

  include '::sudo'
  ::sudo::conf { 'wheel':
    priority => 10,
    content  => '%wheel     ALL=(ALL)       ALL',
  }
}

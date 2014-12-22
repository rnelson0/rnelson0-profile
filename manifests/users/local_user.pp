# == Define: profile::users::local_user
#
# Definition for a local user
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
#  ::profile::users::local_user { 'username':
#    id               => 'username',
#    state            => 'present',
#    comment          => 'Real Name",
#    groups           => ['group1', 'group2'],
#    password         => 'encryptedstring',
#    password_max_age => 90,
#  }
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
define profile::users::local_user (
  $state,
  $id,
  $comment,
  $groups,
  $password,
  $password_max_age = 90,
) {
  user { $id:
    ensure           => $state,
    shell            => '/bin/bash',
    home             => "/home/${id}",
    comment          => $comment,
    managehome       => true,
    groups           => $groups,
    password_max_age => $password_max_age,
  }

  case $::osfamily {
    RedHat: {$action = "/bin/sed -i -e 's/${id}:!!:/${id}:${password}:/g' /etc/shadow; chage -d 0 ${id}"}
    Debian: {$action = "/bin/sed -i -e 's/${id}:x:/${id}:${password}:/g' /etc/shadow; chage -d 0 ${id}"}
    default: { }
  }

  exec { $action:
    path    => '/usr/bin:/usr/sbin:/bin',
    onlyif  => "egrep -q  -e '${id}:!!:' -e '${id}:x:' /etc/shadow",
    require => User[$id]
  }
}

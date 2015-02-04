# == Class: profile::rvm
#
# RVM gem and version settings
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2015 Rob Nelson
#
class profile::rvm {
  include '::rvm'

  $ruby_version = 'ruby-1.9.3-p551'
  rvm_system_ruby { $ruby_version:
    ensure      => present,
    default_use => true,
  }

  rvm_gem {'rspec-puppet':
    ensure       => '2.0.0',
    ruby_version => $ruby_version,
    require      => Rvm_system_ruby[$ruby_version],
  }
  rvm_gem {'puppet':
    ensure       => '3.7.3',
    ruby_version => $ruby_version,
    require      => Rvm_system_ruby[$ruby_version],
  }
  rvm_gem {'fpm':
    ensure       => '1.3.3',
    ruby_version => $ruby_version,
    require      => Rvm_system_ruby[$ruby_version],
  }
  rvm_gem {'puppet-lint':
    ensure       => '1.1.0',
    ruby_version => $ruby_version,
    require      => Rvm_system_ruby[$ruby_version],
  }
  rvm_gem {'puppetlabs_spec_helper':
    ensure       => '0.8.2',
    ruby_version => $ruby_version,
    require      => Rvm_system_ruby[$ruby_version],
  }
}

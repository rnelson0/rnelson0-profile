class profile::rvm {
  include rvm

  rvm_system_ruby {
    'ruby-2.0':
      ensure      => present,
      default_use => true,
  }
}

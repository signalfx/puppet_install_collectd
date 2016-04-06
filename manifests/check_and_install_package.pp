# Checks if a package is defined and install otherwise
#
define collectd::check_and_install_package {
  if(!defined(Package[$title])){
    package { $title:
      ensure => present
    }
  }
}
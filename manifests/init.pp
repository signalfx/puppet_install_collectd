# Class: install_collectd
#
# This module installs collectd from SignalFx repositories
#
class install_collectd {
    
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
    
    include 'install_collectd::install_repo'

    case $::osfamily {
        'Debian': {

                package { 'collectd-core':
                        ensure           => latest,
                        require          => Class['install_repo']
                }

                class { '::collectd':
                        purge            => true,
                        recurse          => true,
                        purge_config     => true,
                        version          => latest,
                        require          => Package['collectd-core']
                }
    
        }
  
        'Redhat': {

                class { '::collectd':
                        purge            => true,
                        recurse          => true,
                        purge_config     => true,
                        version          => latest,
                        require          => Class['install_repo']
                }

                package { ['collectd-disk', 'collectd-write_http']:
                        ensure           => latest,
                        provider         => 'yum',
                        require          => Class['install_repo']
                }
        }
  
        default: {
            fail("Your osfamily : ${::osfamily} is not supported.")
        }
    }
}

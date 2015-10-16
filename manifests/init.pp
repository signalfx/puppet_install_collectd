# Class: install_collectd
#
# This module installs collectd from SignalFx repositories
#
class install_collectd (
    $ensure = present,
    $ppa = 'ppa:signalfx/collectd-release'
) {
    
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
    exec {"data":
      command => "date",
    } 
    class { "install_collectd::install_collectd_repo":
      ppa => $ppa,
    }
    exec {"data 11111 ":
      command => "date",
    }

    case $::osfamily {
        'Debian': {

                package { 'collectd-core':
                        ensure  => $ensure,
                        require => Class['install_collectd_repo']
                }

                class { '::collectd':
                        purge        => true,
                        recurse      => true,
                        purge_config => true,
                        version      => $ensure,
                        require      => Package['collectd-core']
                }
    
        }
  
        'Redhat': {

                class { '::collectd':
                        purge        => true,
                        recurse      => true,
                        purge_config => true,
                        version      => $ensure,
                        require      => Class['install_collectd_repo']
                }

                package { ['collectd-disk', 'collectd-write_http']:
                        ensure   => $ensure,
                        provider => 'yum',
                        require  => Class['install_collectd_repo']
                }
        }
  
        default: {
          if versioncmp($::facterversion, '1.6.18') <= 0 and $::operatingsystem == 'Amazon' {
            fail("Your facter version ${::facterversion} is not supported by our module. More info can be found at https://support.signalfx.com/hc/en-us/articles/205675369")
          }else {
            fail("Your osfamily : ${::osfamily} is not supported.")
          }
        }
    }
}

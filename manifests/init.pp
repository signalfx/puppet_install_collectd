# Class: install_collectd
#
# This module installs collectd from SignalFx repositories
#
class install_collectd {
    
    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
    
    include 'install_repo'

    case $::osfamily {
        'Debian': {

		package { 'collectd-core':
			ensure => latest,
			require => Class ['install_repo']
		}

                class { '::collectd':
                        purge        => true,
                        recurse      => true,
                        purge_config => true,
                        version => latest,
			require => Package ['collectd-core']
                }
		
        }
	
	'Redhat': {

                class { '::collectd':
                        purge        => true,
                        recurse      => true,
                        purge_config => true,
                        version => latest,
                	require => Class ['install_repo']
		}

		package { ['collectd-disk', 'collectd-write_http']:
			provider => 'yum',
                        ensure => latest,
			require => Class ['install_repo']
		}
        }
	
        default: {
            fail("${::osfamily} is not supported.")
        }
    }
}


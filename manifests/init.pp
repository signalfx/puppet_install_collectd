# Class: install_collectd
#
# This module installs collectd from SignalFx repositories
#
class install_collectd {
    
    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
    
    case $::osfamily {
        'Debian': {

		package { 'collectd-core':
			ensure => latest,
			require => Exec['apt-get update']
		}

                class { '::collectd':
                        purge        => true,
                        recurse      => true,
                        purge_config => true,
                        version => latest,
                        require => Exec['apt-get update']
                }
		
                exec { 'apt-get update':
                        command => 'apt-get update',
                        require => Exec['add-apt-repository']
                }

                exec { 'add-apt-repository':
                        command => 'apt-get -y install software-properties-common python-software-properties  && sudo add-apt-repository ppa:uday-d/signalfx-collectd1/',
                        require => Exec['apt-get update II']
                }

                exec { 'apt-get update II':
                        command => 'apt-get update',
                }

        }

        default: {
            fail("${::osfamily} is not supported.")
        }
    }
}


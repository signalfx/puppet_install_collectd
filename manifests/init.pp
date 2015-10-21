# Class: install_collectd
#
# This module installs collectd from SignalFx repositories
#
class install_collectd (
    $ensure = present,
    $ppa = 'ppa:signalfx/collectd-release'
)  inherits install_collectd::repo_params {

    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }


    case $::osfamily {
        'Debian': {
          if !('ppa:signalfx' in $ppa) {
              exec { 'add apt-key':
                  command => 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68EA6297FE128AB0',
                  before  => Exec['add SignalFx ppa to software sources']
              }
          }
          exec { 'add SignalFx ppa to software sources':
              # software-properties-common is the source package for
              # add-apt-repository command (after Ubuntu 13.10)
              # python-software-properties is the source package for
              # add-apt-repository command (before Ubuntu 13.10)
              command    => "apt-get update &&
                             apt-get -y install software-properties-common &&
                             apt-get -y install python-software-properties &&
                             add-apt-repository ${ppa} &&
                             apt-get update",
              before => Package['collectd-core', 'collectd']
           }
           

           package { ['collectd-core', 'collectd']:
               ensure  => $ensure,
           } 
           install_collectd::collectd_utils { 'debian_utils':
               purge           => true,
               recurse         => true,
               purge_config    => true,
               plugin_conf_dir => '/etc/collectd/conf.d',
               config_file     => '/etc/collectd/collectd.conf',
               require         => Package['collectd-core', 'collectd']
           }

        }

        'Redhat': {
          package { $install_collectd::repo_params::old_repo_name:
               ensure  => absent
          }

          package { $install_collectd::repo_params::repo_name:
               ensure   => latest,
               provider => 'rpm',
               source   => $install_collectd::repo_params::repo_source,
               before   => Package['collectd', 'collectd-disk', 'collectd-write_http']
          }

          package { ['collectd', 'collectd-disk', 'collectd-write_http']:
               ensure   => $ensure,
               provider => 'yum'
          }
          install_collectd::collectd_utils { 'redhat_utils':
               purge           => true,
               recurse         => true,
               purge_config    => true,
               plugin_conf_dir => '/etc/collectd.d',
               config_file     => '/etc/collectd.conf',
               require         => Package['collectd', 'collectd-disk', 'collectd-write_http']
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

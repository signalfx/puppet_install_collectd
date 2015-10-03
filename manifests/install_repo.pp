# installs the SignalFx repositories on your system
#
class install_collectd::install_repo inherits install_collectd::repo_params {

    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

    case $::osfamily {
        'Debian': {
            exec { 'add SignalFx ppa to software sources':
                # software-properties-common is the source package for
                # add-apt-repository command (after Ubuntu 13.10)
                # python-software-properties is the source package for
                # add-apt-repository command (before Ubuntu 13.10)
                command    => 'apt-get update &&
                               apt-get -y install software-properties-common && 
                               apt-get -y install python-software-properties && 
                               add-apt-repository ppa:signalfx/collectd-release &&
                               apt-get update',
                  }
          }

        'Redhat':{

            if $::operatingsystemmajrelease == '5' {
                    exec { 'install SignalFx repo  on centos 5':
                    command   =>  "yum -y install wget &&
                                   wget ${install_collectd::repo_params::repo_source} &&
                                   yum -y install --nogpgcheck ${install_collectd::repo_params::repo_name} &&
                                   rm -f ${install_collectd::repo_params::repo_name}"
                    }
            }
            else {
                    package { $install_collectd::repo_params::repo_name:
                            ensure   => latest,
                            provider => 'rpm',
                            source   => $install_collectd::repo_params::repo_source
                    }
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

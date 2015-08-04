class install_collectd::install_repo inherits install_collectd::repo_params {

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    case $::osfamily {
        'Debian': {
                exec { 'add SignalFx ppa to software sources':
                        # software-properties-common is the source package for add-apt-repository command (after Ubuntu 13.10)
                        # python-software-properties is the source package for add-apt-repository command (before Ubuntu 13.10)
                        command => 'apt-get update &&
                                    apt-get -y install software-properties-common && 
                                    apt-get -y install python-software-properties && 
                                    add-apt-repository ppa:signalfx/collectd-release &&
                                    apt-get update',
                }
        }

        'Redhat':{

            if $::operatingsystemmajrelease == "5" {
                    exec { "install SignalFx repo  on centos 5":
                            command => "yum -y install wget &&
                                        wget ${repo_source} &&
                                        yum -y install --nogpgcheck ${repo_name} &&
                                        rm -f ${repo_name}"
                    }
            }
            else {
                    package { $repo_name:
                            provider => 'rpm',
                            ensure => latest,
                            source => $repo_source
                    }
            }
        }
    }

}

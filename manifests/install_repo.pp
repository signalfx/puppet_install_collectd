class install_repo inherits install_collectd::repo_params {

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    case $::osfamily {
        'Debian': {
                exec { 'add SignalFx ppa to software sources':
                        command => 'apt-get update &&
                                    apt-get -y install software-properties-common && # source package for add-apt-repository command (after Ubuntu 13.10)
                                    apt-get -y install python-software-properties && # source package for add-apt-repository command (before Ubuntu 13.10)
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

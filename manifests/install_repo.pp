class install_repo inherits install_collectd::repo_params {

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    case $::osfamily {
        'Debian': {
                exec { 'add-apt-repository':
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
                                        rm -rf ${repo_name}"
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

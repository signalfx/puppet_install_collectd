# contains the urls and other information about SignalFx repositories
#
class install_collectd::repo_params {
        case $::operatingsystem {
                'Ubuntu':{}
    'CentOS': {
                        case $::operatingsystemmajrelease {
                                '7': {
                                      $repo_name       = 'SignalFx-RPMs-centos-7-release'
                                      $repo_source     = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-RPMs-centos-7-release-1.0-0.noarch.rpm'
                                }
                                '6': {
                                      $repo_name       = 'SignalFx-RPMs-centos-6-release'
                                      $repo_source     = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-RPMs-centos-6-release-1.0-0.noarch.rpm'
        }
                                '5': {
                                      $repo_name       = 'SignalFx-RPMs-centos-5-release-1.0-0.noarch.rpm'
                                      $repo_source     = 'https://s3.amazonaws.com/public-downloads--signalfuse-com/rpms/SignalFx-rpms/release/SignalFx-RPMs-centos-5-release-1.0-0.noarch.rpm'
        }
                                default: {
                                        fail("Your centos os major release : ${::operatingsystemmajrelease} is not supported.")
                                }
                        }
                }
                'Amazon': {
                        case $::operatingsystemrelease {
                                '2015.03': {
                                      $repo_name       = 'SignalFx-RPMs-AWS_EC2_Linux_2015_03-release'
                                      $repo_source     = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-RPMs-AWS_EC2_Linux_2015_03-release-1.0-0.noarch.rpm'
                                }
                                '2014.09': {
                                      $repo_name       = 'SignalFx-RPMs-AWS_EC2_Linux_2014_09-release'
                                      $repo_source     = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-RPMs-AWS_EC2_Linux_2014_09-release-1.0-0.noarch.rpm'
                                }
                                default: {
                                      fail("Your operating system release : ${::operatingsystemrelease} is not supported.")
                                }
                        }
                }
                default: {
                        fail("Your operating system : ${::operatingsystem} is not supported.")
                }
        }
}

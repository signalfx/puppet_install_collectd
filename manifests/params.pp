# Contains important parameters, urls
#
class collectd::params {
        $fqdnlookup             = true
        $hostname               = $::hostname
        $interval               = 10
        $timeout                = 2
        $read_threads           = 5
        $write_queue_limit_high = 2000000
        $write_queue_limit_low  = 1800000
        $collect_internal_stats = true
        $flush_interval         = 10
        $flush_timeout          = 2
        $log_file               = '/var/log/signalfx-collectd.log'
        
        $ensure_signalfx_plugin_version = present
        $dimension_list            = {}
        $signalfx_api_endpoint     = 'https://ingest.signalfx.com/v1/collectd'
        $write_http_timeout        = 3000
        $write_http_buffersize     = 65536
        $aws_integration           = true
        $write_http_log_http_error = true
        $write_http_flush_interval = 10
        
        $signalfx_plugin_log_traces        = true
		    $signalfx_plugin_interactive       = false
		    $signalfx_plugin_notifications     = true
		    $signalfx_plugin_notify_level      = 'OKAY'
		    $signalfx_plugin_dpm               = false
        
        # Do not change 'plugin_config_dir', it is here for code reuse
        if $::osfamily == 'Debian' {
			    $plugin_config_dir = '/etc/collectd/managed_config'
			  }
			  elsif $::osfamily == 'Redhat' {
			    $plugin_config_dir = '/etc/collectd.d/managed_config'
			  }
        
        case $::operatingsystem {
                'Ubuntu':{
                    $signalfx_public_keyid = 'C94EDC608899B00511CCBA4D68EA6297FE128AB0' # public key to repository hosted on launchpad
                    $signalfx_collectd_repo_source  = 'ppa:signalfx/collectd-release'
                    $signalfx_plugin_repo_source    = 'ppa:signalfx/collectd-plugin-release'
                }
                'Debian':{
                    case $::operatingsystemmajrelease {
                        '7': {
                              $signalfx_public_keyid          = '91668001288D1C6D2885D651185894C15AE495F6' # public key to repository hosted on AWS S3
                              $signalfx_collectd_repo_source  = 'deb https://dl.signalfx.com/debs/collectd/wheezy/release /'
                              $signalfx_plugin_repo_source    = 'deb https://dl.signalfx.com/debs/signalfx-collectd-plugin/wheezy/release /'
                        }
                        '8': {
                              $signalfx_public_keyid          = '91668001288D1C6D2885D651185894C15AE495F6' # public key to repository hosted on AWS S3
                              $signalfx_collectd_repo_source  = 'deb https://dl.signalfx.com/debs/collectd/jessie/release /'
                              $signalfx_plugin_repo_source    = 'deb https://dl.signalfx.com/debs/signalfx-collectd-plugin/jessie/release /'
                        }
                        default: {
                                fail("Your Debian OS major release : ${::operatingsystemmajrelease} is not supported.")
                        }
                    }
                }
                'CentOS': {
                    case $::operatingsystemmajrelease {
                        '7': {
                            $old_signalfx_collectd_repo_source   = 'SignalFx-collectd-RPMs-centos-7-release'
                            $signalfx_collectd_repo_source       = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd-RPMs-centos-release-latest.noarch.rpm'
                            $signalfx_plugin_repo_source         = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd_plugin-RPMs-centos-release-latest.noarch.rpm'
                        }
                        '6': {
                            $old_signalfx_collectd_repo_source   = 'SignalFx-collectd-RPMs-centos-6-release'
                            $signalfx_collectd_repo_source       = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd-RPMs-centos-release-latest.noarch.rpm'
                            $signalfx_plugin_repo_source         = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd_plugin-RPMs-centos-release-latest.noarch.rpm'
                        }
                        default: {
                            fail("Your CentOS OS major release : ${::operatingsystemmajrelease} is not supported.")
                        }
                    }
                }
                'Amazon': {
                        case $::operatingsystemrelease {
                            '2015.09': {
                                $old_signalfx_collectd_repo_source   = 'SignalFx-collectd-RPMs-AWS_EC2_Linux_2015_09-release'
                                $signalfx_collectd_repo_source       = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
                                $signalfx_plugin_repo_source         = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd_plugin-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
                            }
                            '2015.03': {
                                $old_signalfx_collectd_repo_source   = 'SignalFx-collectd-RPMs-AWS_EC2_Linux_2015_03-release'
                                $signalfx_collectd_repo_source       = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
                                $signalfx_plugin_repo_source         = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd_plugin-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
                            }
                            '2014.09': {
                                $old_signalfx_collectd_repo_source   = 'SignalFx-collectd-RPMs-AWS_EC2_Linux_2014_09-release'
                                $signalfx_collectd_repo_source       = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
                                $signalfx_plugin_repo_source         = 'https://dl.signalfx.com/rpms/SignalFx-rpms/release/SignalFx-collectd_plugin-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
                            }
                            default: {
                              if versioncmp($::facterversion, '1.6.18') <= 0 and $::operatingsystem == 'Amazon' {
                                fail("Your facter version ${::facterversion} is not supported by our module. More info can be found at https://support.signalfx.com/hc/en-us/articles/205675369")
                              }else {
                                  fail("Your operating system release : ${::operatingsystemrelease} is not supported.")
                              }
                            }
                        }
                }
                default: {
                        fail("Your operating system : ${::operatingsystem} is not supported.")
                }
        }
}

# Configure the installed collectd package
#
class collectd::config inherits collectd {
  File {
    mode   => '0750',
    owner  => 'root',
    group  => 'root',
  }
  file { $collectd::log_file:
    ensure => present
  } ->
  file { $collectd::params::collectd_config_file:
      content => template('collectd/collectd.conf.erb'),
      notify  => Class['collectd::service'],
  }
}

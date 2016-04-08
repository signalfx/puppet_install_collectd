# Configure the installed collectd package
#
class collectd::config inherits collectd {
  File {
    mode   => '0750',
    owner  => 'root',
    group  => 'root',
  }
  file { $collectd::params::plugin_config_dir_tree :
      ensure => directory
  } ->
  file { $collectd::log_file:
    ensure => present
  } ->
  file { $collectd::params::collectd_config_file:
      content => template('collectd/collectd.conf.erb'),
      notify  => Service['collectd'],
  } ->
  file { $collectd::params::filtering_config_file:
      content => template('collectd/filtering.conf.erb'),
      notify  => Service['collectd'],
  }
  check_and_create_directory { '/usr/share/' : } ->
  check_and_create_directory { '/usr/share/collectd/' : } ->
  check_and_create_directory { '/usr/share/collectd/java' : } ->
  check_and_create_directory { '/usr/share/collectd/python' : }
}

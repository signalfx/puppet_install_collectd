#
#
class collectd::create_plugin_dirs {
  include collectd::params
  File {
    mode   => '0750',
    owner  => 'root',
    group  => 'root',
  }
  
  file { $collectd::params::plugin_config_dir_tree :
      ensure => directory
  } ->
  file { $collectd::params::filtering_config_file:
      content => template('collectd/filtering.conf.erb'),
      notify  => Class['collectd::service'],
  }
  # write file line into collectd.conf file
  #
}
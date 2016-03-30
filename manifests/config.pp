# Configure the installed collectd package
#
define collectd::config {
  if $::osfamily == 'Debian' {
      $plugin_config_dir_tree      = ['/etc/collectd/', '/etc/collectd/managed_config', '/etc/collectd/filtering_config']
      $include_plugin_dirs         = ['/etc/collectd/managed_config', '/etc/collectd/filtering_config']
      $config_file                 = '/etc/collectd/collectd.conf'
      $filtering_config_file       = '/etc/collectd/filtering_config/filtering.conf'
      $aggregation_config_file     = '/etc/collectd/managed_config/10-aggregation-cpu.conf'
  }
  if $::osfamily == 'Redhat' {
      $plugin_config_dir_tree     = ['/etc/collectd.d/', '/etc/collectd.d/managed_config', '/etc/collectd.d/filtering_config']
      $include_plugin_dirs        = ['/etc/collectd.d/managed_config', '/etc/collectd.d/filtering_config']
      $config_file                = '/etc/collectd.conf'
      $filtering_config_file      = '/etc/collectd.d/filtering_config/filtering.conf'
      $aggregation_config_file    = '/etc/collectd.d/managed_config/10-aggregation-cpu.conf'
  }
  
  file { $plugin_config_dir_tree :
      ensure => directory,
      mode   => '0750',
      owner  => 'root',
      group  => 'root',
  } ->
  file { $config_file:
      content => template('collectd/collectd.conf.erb'),
      notify  => Service['collectd'],
  } ->
  file { $aggregation_config_file :
      content => template('collectd/aggregation-cpu.conf.erb'),
      notify  => Service['collectd']
  } ->
  file { $filtering_config_file:
      content => template('collectd/filtering.conf.erb'),
      notify  => Service['collectd'],
  }
  
  file { $collectd::log_file:
    ensure => present
  }
  
}

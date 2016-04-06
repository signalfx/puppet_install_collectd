# private
class collectd::plugins::aggregation {
  include collectd::params
  file { "${collectd::params::plugin_config_dir}/10-aggregation-cpu.conf" :
      content => template('collectd/plugins/aggregation-cpu.conf.erb'),
      notify  => Class['collectd::service'],
      require => Class['collectd::create_plugin_dir']
  } 
}
# Configure write_http plugin and signalfx-collectd-plugin to send metrics to SignalFx.
#
define collectd::send_metrics {
  $dimensions = get_dimensions($collectd::dimension_list, $collectd::aws_integration)
  $signalfx_api_endpoint_with_dimensions = "${collectd::signalfx_api_endpoint}${dimensions}"
  notify {"Collectd will transmit metrics to this url: ${signalfx_api_endpoint_with_dimensions}":}
  
  # configure write_http plugin
  file { 'load write_http plugin':
    ensure  => present,
    path    => "${collectd::params::plugin_config_dir}/10-write_http.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('collectd/write_http.conf.erb'),
    notify  => Service['collectd'],
    require => File[$collectd::params::plugin_config_dir]
  }
  
  # signalfx plugin is installed along with collectd in install.pp
  # now, configure signalfx plugin
  file { 'load Signalfx plugin':
    ensure  => present,
    path    => "${collectd::params::plugin_config_dir}/10-signalfx.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('collectd/signalfx_plugin.conf.erb'),
    notify  => Service['collectd'],
    require => File[$collectd::params::plugin_config_dir]
  }
  
}

#
#
class collectd::plugins::signalfx(
  $ensure_signalfx_plugin_version    = $collectd::ensure_signalfx_plugin_version,
  $signalfx_plugin_repo_source       = $collectd::signalfx_plugin_repo_source,
  $aws_integration                   = $collectd::aws_integration,
  $signalfx_plugin_log_traces        = $collectd::signalfx_plugin_log_traces,
  $signalfx_plugin_interactive       = $collectd::signalfx_plugin_interactive,
  $signalfx_plugin_notifications     = $collectd::signalfx_plugin_notifications,
  $signalfx_plugin_notify_level      = $collectd::signalfx_plugin_notify_level,
  $signalfx_plugin_dpm               = $collectd::signalfx_plugin_dpm
) inherits collectd {
  
  $dimensions = get_dimensions($dimension_list, $aws_integration)
  $signalfx_api_endpoint_with_dimensions = "${signalfx_api_endpoint}${dimensions}"
  notify {"Collectd will transmit metrics to this url: ${signalfx_api_endpoint_with_dimensions}":}
  
  check_and_install_package { ['signalfx-collectd-plugin', 'collectd-python']:
    require => Class['collectd::get_signalfx_repository']
  }
  
  file { 'load Signalfx plugin':
    ensure  => present,
    path    => "${collectd::params::plugin_config_dir}/10-signalfx.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('collectd/signalfx_plugin.conf.erb'),
    notify  => Class['collectd::service'],
    require => [Class['collectd::create_plugin_dirs'], Package['collectd-python', 'signalfx-collectd-python']]
  }
}
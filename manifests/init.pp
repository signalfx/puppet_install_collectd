# Class: collectd
#
# This module installs collectd from SignalFx repositories
#
class collectd (
    $signalfx_api_token,
    $ensure_signalfx_collectd_version  = present,
    $signalfx_collectd_repo_source     = $collectd::params::signalfx_collectd_repo_source,
    $fqdnlookup                        = $collectd::params::fqdnlookup,
    $hostname                          = $collectd::params::hostname,
    $interval                          = $collectd::params::interval,
    $timeout                           = $collectd::params::timeout,
    $read_threads                      = $collectd::params::read_threads,
    $write_queue_limit_high            = $collectd::params::write_queue_limit_high,
    $write_queue_limit_low             = $collectd::params::write_queue_limit_low,
    $collect_internal_stats            = $collectd::params::collect_internal_stats,
    $log_file                          = $collectd::params::log_file,
    $dimension_list                    = $collectd::params::dimension_list,
    $signalfx_api_endpoint             = $collectd::params::signalfx_api_endpoint,
    $write_http_timeout                = $collectd::params::write_http_timeout,
    $write_http_buffersize             = $collectd::params::write_http_buffersize,
    $write_http_flush_interval         = $collectd::params::write_http_flush_interval,
    $write_http_log_http_error         = $collectd::params::write_http_log_http_error,
    $aws_integration                   = $collectd::params::aws_integration,
    $ensure_signalfx_plugin_version    = $collectd::params::ensure_signalfx_plugin_version,
    $signalfx_plugin_repo_source       = $collectd::params::signalfx_plugin_repo_source,
    $signalfx_plugin_log_traces        = $collectd::params::signalfx_plugin_log_traces,
    $signalfx_plugin_interactive       = $collectd::params::signalfx_plugin_interactive,
    $signalfx_plugin_notifications     = $collectd::params::signalfx_plugin_notifications,
    $signalfx_plugin_notify_level      = $collectd::params::signalfx_plugin_notify_level,
    $signalfx_plugin_dpm               = $collectd::params::signalfx_plugin_dpm
)  inherits collectd::params {
  
  # Be careful of dependencies in this file ( -> )
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  collectd::check_os_compatibility { $title: }
  
  anchor { 'collectd::begin': } ->
	  class { '::collectd::get_signalfx_repository': } ->
	  class { '::collectd::install': } ->
	  class { '::collectd::config': } ->
	  class { '::collectd::create_plugin_dirs': } ~>
	  class { '::collectd::service': }
  anchor { 'collectd::end': }
  
  class { 'collectd::plugins::write_http': }
  class { '::collectd::plugins::signalfx': }
}

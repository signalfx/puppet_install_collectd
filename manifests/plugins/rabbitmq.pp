# rabbitmq plugin
#
class collectd::plugins::rabbitmq (
  $username,
  $password,
  $host,
  $port,
  $collect_channels     = true,
  $collect_connections  = true,
  $collect_exchanges    = true,
  $collect_nodes        = true,
  $collect_queues       = true,
  $http_timeout         = 'UNSET',
  $verbosity_level      = 'UNSET',
  $field_length         = 1024,
) {
  
  file { '/opt/collectd-rabbitmq':
    ensure => directory,
    mode   => '0750',
	  owner  => 'root',
	  group  => 'root',
  } ->
  file { 'rabbitmq.py':
    ensure  => present,
    path    => '/opt/collectd-rabbitmq/rabbitmq.py',
    owner   => 'root',
    group   => 'root',
    content => template('collectd/plugins/rabbitmq/rabbitmq.py.erb')
  } ->
  file { 'metric_info.py':
    ensure  => present,
    path    => '/opt/collectd-rabbitmq/metric_info.py',
    owner   => 'root',
    group   => 'root',
    content => template('collectd/plugins/rabbitmq/metric_info.py.erb')
  } ->
  collectd::plugins::plugin_common { 'rabbitmq':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-rabbitmq.conf',
    plugin_template_name => 'rabbitmq/rabbitmq.conf.erb'
  }
}

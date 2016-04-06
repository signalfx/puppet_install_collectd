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
  $http_timeout         = 60,
  $verbosity_level      = 'info',
  $field_length         = 1024,
) {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  # Be careful of dependencies here ( -> )
  collectd::check_os_compatibility { $title:
  }
  
  if(!defined(Class['git'])){
    exec { 'update system':
      command => "${collectd::update_system}",
      unless  => 'test git'
    } ->
    class {'git':}
  }
  
  vcsrepo { '/opt/collectd-rabbitmq':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/signalfx/collectd-rabbitmq',
  } ->
  collectd::plugins::plugin_common { 'rabbitmq':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-rabbitmq.conf',
    plugin_template_name => 'rabbitmq/rabbitmq.conf.erb'
  }
}

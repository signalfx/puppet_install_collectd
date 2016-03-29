# redis slave plugin
#
class collectd::plugins::redis_slave (
  $host,
  $port,
  $auth    = 'UNSET',
  $verbose = false
) {
  if !defined( File['/opt/redis-collectd-plugin/redis_info.py'] ) {
    file { '/opt/redis-collectd-plugin/':
      ensure => directory
    } ->
    file { '/opt/redis-collectd-plugin/redis_info.py':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      content => template('collectd/plugins/redis/redis_info.py.erb')
    }
  }
  
  collectd::plugins::plugin_common { 'redis-slave':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-redis-slave.conf',
    plugin_template_name => 'redis/redis_slave.conf.erb',
    require              => File['/opt/redis-collectd-plugin/redis_info.py']
  }

}

# redis master plugin
#
class collectd::plugins::redis_master (
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
  
  collectd::plugins::plugin_common { 'redis-master':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-redis-master.conf',
    plugin_template_name => 'redis/redis_master.conf.erb',
    require              => File['/opt/redis-collectd-plugin/redis_info.py']
  }

}

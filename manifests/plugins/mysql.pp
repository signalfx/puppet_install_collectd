# mysql plugin
#
class collectd::plugins::mysql (
  $host,
  $user,
  $password,
  $database,
  $socket = 'UNSET'
)  {
  
  if $socket == 'UNSET' {
    if $::osfamily == 'Debian' {
      $socket_file = '/var/lib/mysqld/mysqld.sock'
    }
    elsif $::osfamily == 'Redhat' {
      $socket_file = '/var/lib/mysql/mysql.sock'
    }
  }else {
    $socket_file = $socket
  }

  collectd::plugins::plugin_common { 'mysql':
    package_name         => 'collectd-mysql',
    plugin_file_name     => '10-mysql.conf',
    plugin_template_name => 'mysql/mysql.conf.erb'
  }
}

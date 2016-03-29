# apache plugin
#
class collectd::plugins::apache (
  $instance_name  = 'myapacheinstance',
  $url           = 'http://localhost/mod_status?auto'
) {
  
  collectd::plugins::plugin_common { 'apache':
    package_name         => 'collectd-apache',
    plugin_file_name     => '10-apache.conf',
    plugin_template_name => 'apache/apache.conf.erb'
  }
}

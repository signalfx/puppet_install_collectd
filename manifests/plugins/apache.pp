# apache plugin
#
class collectd::plugins::apache (
  $instance_name  = 'myapacheinstance',
  $url           = 'http://localhost/mod_status?auto'
) {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  # Be careful of dependencies here ( -> )
  collectd::check_os_compatibility { $title:
  }
  
  collectd::plugins::plugin_common { 'apache':
    package_name         => 'collectd-apache',
    plugin_file_name     => '10-apache.conf',
    plugin_template_name => 'apache/apache.conf.erb'
  }
}

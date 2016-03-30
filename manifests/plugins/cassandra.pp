# cassandra plugin
#
class collectd::plugins::cassandra (
  $hostname = $::hostname
) {
  include collectd::plugins::jmx
  collectd::plugins::plugin_common { 'cassandra':
    plugin_file_name     => '20-cassandra.conf',
    plugin_template_name => 'cassandra/cassandra.conf.erb'
  }
}
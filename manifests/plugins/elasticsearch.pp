# elasticsearch plugin
#
class collectd::plugins::elasticsearch (
        $clustername           = 'elasticsearch',
        $indexes               = '_all',
        $enable_index_stats    = true,
        $enable_cluster_health = true
) {
  
  file { ['/usr/share/', '/usr/share/collectd/']:
    ensure => directory,
    mode   => '0750',
    owner  => 'root',
    group  => 'root',
  } ->
  file { 'get elasticsearch python module':
    ensure  => present,
    path    => '/usr/share/collectd/elasticsearch_collectd.py',
    owner   => 'root',
    group   => 'root',
    content => template('collectd/plugins/elasticsearch/elasticsearch_collectd.py.erb')
  } ->
  collectd::plugins::plugin_common { 'elasticsearch':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-elasticsearch.conf',
    plugin_template_name => 'elasticsearch/elasticsearch.conf.erb'
  }
}

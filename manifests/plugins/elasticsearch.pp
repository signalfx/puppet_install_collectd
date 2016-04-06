# elasticsearch plugin
#
class collectd::plugins::elasticsearch (
        $clustername           = 'elasticsearch',
        $indexes               = '_all',
        $enable_index_stats    = true,
        $enable_cluster_health = true
) {
  
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  # Be careful of dependencies here ( -> )
  collectd::check_os_compatibility { $title:
  }
  
  check_and_create_directory { '/usr/share/': } ->
  check_and_create_directory { '/usr/share/collectd/' : }
  
  if(!defined(Class['git'])){
    exec { 'update system':
      command => "${collectd::update_system}",
      unless  => 'test git'
    } ->
    class {'git':}
  }
  
  vcsrepo { '/tmp/collectd-elasticsearch':
	  ensure   => present,
	  provider => git,
	  source   => 'https://github.com/signalfx/collectd-elasticsearch',
	} ->
	exec { 'copy required files for elasticsearch plugin' :
	  command => 'cp /tmp/collectd-elasticsearch/elasticsearch_collectd.py /usr/share/collectd/'
	} ->
  collectd::plugins::plugin_common { 'elasticsearch':
    package_name         => 'collectd-python',
    plugin_file_name     => '10-elasticsearch.conf',
    plugin_template_name => 'elasticsearch/elasticsearch.conf.erb'
  }
}

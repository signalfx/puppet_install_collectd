# jmx plugin
#
class collectd::plugins::jmx {
  include collectd
  
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  # Be careful of dependencies here ( -> )
  collectd::check_os_compatibility { $title:
  }
  
  $typesdbfile = "${collectd::params::plugin_config_dir}/signalfx_types_db"
  
  file_line { 'Ensure collectd typesdb':
    ensure => present,
    line   => "TypesDB \"/usr/share/collectd/types.db\"",
    path   => $collectd::params::collectd_config_file,
    notify => Service['collectd']
  }

  file { 'Add signalfx typesdb':
    ensure  => present,
    path    => "${collectd::params::plugin_config_dir}/signalfx_types_db",
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('collectd/plugins/jmx/signalfx_types_db.erb'),
  }

  collectd::plugins::plugin_common { 'jmx':
          package_name         => 'collectd-java',
          plugin_file_name     => '10-jmx.conf',
          plugin_template_name => 'jmx/jmx.conf.erb',
          require              => File['Add signalfx typesdb']
  }
  
}
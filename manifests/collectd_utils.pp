#
define install_collectd::collectd_utils (
    $plugin_conf_dir,
    $config_file,
    $purge        = undef,
    $recurse      = undef,
    $purge_config = false
) {
    
    $typesdb                = []
    $include                = [] 
    $interval               = 10
    $threads                = 5
    $timeout                = 2
    $fqdnlookup             = true
    $collectd_hostname      = $::hostname
    $write_queue_limit_high = undef
    $write_queue_limit_low  = undef 
   
    file { 'collectd.d':
      ensure  => directory,
      path    => $plugin_conf_dir,
      mode    => '0750',
      owner   => 'root',
      group   => 'root',
      purge   => $purge,
      recurse => $recurse,
      notify  => Service['collectd'],
    }

    $conf_content = $purge_config ? {
      true    => template('install_collectd/collectd.conf.erb'),
      default => undef,
    }

    file { 'collectd.conf':
      path    => $config_file,
      content => $conf_content,
      notify  => Service['collectd'],
    }

    if $purge_config != true {
      # former include of conf_d directory
      file_line { 'include_conf_d':
        ensure => absent,
        line   => "Include \"${plugin_conf_dir}/\"",
        path   => $config_file,
        notify => Service['collectd'],
      }
      # include (conf_d directory)/*.conf
      file_line { 'include_conf_d_dot_conf':
        ensure => present,
        line   => "Include \"${plugin_conf_dir}/*.conf\"",
        path   => $config_file,
        notify => Service['collectd'],
      }
    }

    service { 'collectd':
      ensure  => running,
      enable  => true,
      require => Package['collectd'],
    }

}

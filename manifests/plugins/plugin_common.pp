# common code for the 3rd party plugins
#
define collectd::plugins::plugin_common (
  $plugin_file_name,
  $plugin_template_name,
  $package_name = 'UNSET',
  $typesdbfile = 'UNSET'
){
  
  include collectd
  if $::osfamily == 'RedHat' and $package_name != 'UNSET' {
    collectd::check_and_install_package { $package_name:
      before  => File["load ${plugin_file_name} plugin"],
      require => Collectd::Get_signalfx_repository['collectd']
    }
  }
  
  file { "load ${plugin_file_name} plugin":
    ensure  => present,
    path    => "${collectd::plugin_config_dir}/${plugin_file_name}",
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("collectd/plugins/${plugin_template_name}"),
    notify  => Service['collectd'],
    require => Collectd::Config['collectd']
  }
}

# puppet_install_collectd
A puppet module that just installs collectd from SignalFx repositories

## Usage
```ruby
include 'install_collectd'
```

###### NOTE
After installation, there are no default plugins inside your collectd.conf file. Use the configure_collectd puppet module from SignalFx to configure exact and only required plugins for your collectd to send metrics to SignalFx.

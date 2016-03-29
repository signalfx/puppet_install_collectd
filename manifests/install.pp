# Install collectd, signalfx-collectd-plugin and other important packages
#
define collectd::install {
    if $::osfamily == 'Debian' {
      package { ['collectd-core', 'collectd', 'signalfx-collectd-plugin']:
          ensure  => $collectd::ensure_signalfx_collectd_version,
      }
    }
    if $::osfamily == 'Redhat' {
      # collectd-python is required for signalfx-collectd-plugin
      package { ['collectd', 'collectd-disk', 'collectd-write_http', 'signalfx-collectd-plugin', 'collectd-python']:
        ensure   => $collectd::ensure_signalfx_collectd_version,
        provider => 'yum'
      }
    }
}

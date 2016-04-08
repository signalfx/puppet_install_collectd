# Install collectd, signalfx-collectd-plugin and other important packages
#
class collectd::install {
    if $::osfamily == 'Debian' {
      package { ['collectd-core', 'collectd']:
          ensure  => $collectd::ensure_signalfx_collectd_version,
      }
    }
    if $::osfamily == 'Redhat' {
      package { ['collectd', 'collectd-disk']:
        ensure   => $collectd::ensure_signalfx_collectd_version,
        provider => 'yum'
      }
    }
}
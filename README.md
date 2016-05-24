# puppet_install_collectd

[![Build Status](https://travis-ci.org/signalfx/puppet_install_collectd.svg?branch=travis_tests)](https://travis-ci.org/signalfx/puppet_install_collectd)

## This module has been deprecated! Find a new and up-to-date module at https://forge.puppet.com/signalfx/collectd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with install_collectd](#setup)
    * [What install_collectd affects](#what-install_collectd-affects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

The install_collectd module installs the latest build of collectd from [SignalFx](http://signalfx.com) and keeps it up-to-date.

This is one of three modules provided by SignalFx for managing collectd. See [Module Description](#module-description). 

Module name | Description
------------| ------------
puppet_install_collectd | Install and stay up-to-date with SignalFx's latest build of collectd.
[configure_collectd_plugins](https://forge.puppetlabs.com/signalfx/configure_collectd_plugins) | Enable and configure a set of collectd plugins that work well with SignalFx.
[send_collectd_metrics](https://forge.puppetlabs.com/signalfx/send_collectd_metrics) | Configure collectd to send metrics to SignalFx.

## Setup
Install the latest release of install_collectd module from SignalFx using:
```shell
puppet module install signalfx/install_collectd
```

### What install_collectd affects

The install_collectd module only installs SignalFx's latest build of collectd on your system. SignalFx provides additional modules to configure collectd plugins and send metrics to SignalFx. See [Module Description](#module-description).

## Usage

Install_collectd module accepts various parameters:

**1. ensure**
Default value of ensure is present. There are three supported cases:  
  1.1. If your system does not have any existing collectd, the default value, 'present' allows the module to install the latest collectd packages from SignalFx repositories.  
  1.2. If you want to install only a specific version of collectd, you can set 'version' as this parameter's value. For example, set ensure as '5.5.0-sfx3~trusty' to get the exact specified version.  
  1.3. If your system already has collectd, you have to change this value to 'latest' to get the newest version. (Remember to change this value back to present once you have updated all your nodes, else, puppet will be automatically updating your collectd version as new packages are released by SignalFx)  

**2. ppa**  
This optional variable applies to Ubuntu systems. It allows the module to use your local repository(cloned from SignalFx) for collectd packages. Default value is appropriate up-to-date ppa hosted by SignalFx.

```shell
class { 'install_collectd':
  ensure       => "present",
  ppa          => 'ppa:signalfx/collectd-release',
  debian_ppa   => "deb https://dl.signalfx.com/debs/collectd/jessie/release /",
  purge        => undef,
  recurse      => undef,
  purge_config => false
}
```

**3. debian_ppa**
This optional variable applies to Debian GNU/Linux 7 and 8. It allows the module to use your local repository(cloned from SignalFx) for collectd packages. Default value is appropriate up-to-date ppa hosted by SignalFx.

**4. others**
Set purge, recurse and purge_config to true to delete your existing collectd folders in case 1.3 and install just the latest version of collectd. The default values for purge, recurse and purge_config are undef, undef and false respectively.

## Limitations

Currently, the supported operating systems are 
  1. Ubuntu 12.04
  2. Ubuntu 14.04
  3. Ubuntu 15.04
  4. CentOS 6
  5. CentOS 7
  6. Amazon Linux 2014.09
  7. Amazon Linux 2015.03
  8. Amazon Linux 2015.09
  9. Debian GNU/Linux 7 (wheezy)
  10. Debian GNU/Linux 8 (jessie)

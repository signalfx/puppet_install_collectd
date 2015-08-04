# puppet_install_collectd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with install_collectd](#setup)
    * [What install_collectd affects](#what-install_collectd-affects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

The install_collectd module installs collectd from SignalFx repositories on your system and keeps it up-to-date.

## Module Description

Collectd is a system statistics collection daemon. This module pulls the debian and rpm packages of collectd from SignalFx repositories and installs them on your system. The debian packages are pulled from signalfx/collectd-release ppa and the rpm packages are pulled from Amazon s3 bucket.

Once you have installed this module, you may proceed to install [configure_collectd_plugins](https://github.com/signalfx/puppet_configure_collectd_plugins) and [send_collectd_metrics](https://github.com/signalfx/puppet_send_collectd_metrics) puppet modules from SignalFx to configure interesting plugins and send metrics to SignalFx.

## Setup
Install the latest release of install_collectd module from SignalFx using:
```shell
puppet module install signalfx/install_collectd
```

### What install_collectd affects

The install_collectd module installs only the latest version of collectd on your system. It does not configure any plugins. check [configure_collectd_plugins](https://github.com/signalfx/puppet_configure_collectd_plugins) and [send_collectd_metrics](https://github.com/signalfx/puppet_send_collectd_metrics) puppet modules for further functionalities. 


## Usage

The install_collectd module does not have any parameters. Including this module is as simple as:
```shell
node default {
  include 'install_collectd'
}
```

## Limitations

Currently, the supported operating systems are 
  1. Ubuntu 12.04
  2. Ubuntu 14.04
  3. Ubuntu 15.04
  4. CentOS 5
  5. CentOS 6
  6. CentOS 7
  7. Amazon Linux 2014.09
  8. Amazon Linux 2015.03.


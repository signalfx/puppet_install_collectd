# puppet_install_collectd

[![Build Status](https://travis-ci.org/signalfx/puppet_install_collectd.svg?branch=travis_tests)](https://travis-ci.org/signalfx/puppet_install_collectd)

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

## Module Description

Collectd is a system statistics collection daemon. This module pulls SignalFx's latest Debian or RPM package of collectd as appropriate for your system, and uses it to install collectd. Debian packages are pulled from signalfx/collectd-release PPA. RPM packages are pulled from SignalFx's Amazon S3 bucket.

This is one of three modules provided by SignalFx for managing collectd. 

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
  4. CentOS 6
  5. CentOS 7
  6. Amazon Linux 2014.09
  7. Amazon Linux 2015.03
  8. Amazon Linux 2015.09

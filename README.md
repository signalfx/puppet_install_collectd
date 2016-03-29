# puppet_collectd

[![Build Status](https://travis-ci.org/signalfx/puppet_install_collectd.svg?branch=master)](https://travis-ci.org/signalfx/puppet_install_collectd)

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with collectd](#setup)
    * [What collectd affects](#what-collectd-affects)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This Puppet module installs and configures the collectd from [SignalFx](http://signalfx.com), it also configures your collectd to send metrics to SignalFx.

With this module, you can also configure collectd plugins like collectd-rabbitmq, collectd-elasticsearch, collectd-redis etc to send metrics to SignalFx.

## Setup
```shell
puppet module install signalfx/collectd (not released on PuppetForge yet!)
```

### What collectd affects

This module installs and configures collectd on your system to send various metrics to SignalFx. Be careful if you already have a collectd working. It will replace your existing collectd configuration.

## Usage

```shell
class { 'collectd' :
    signalfx_api_token  => 'YOUR_SIGNALFX_API_TOKEN'
}
```

Other valid parameters are (check the params.pp file for default values):

Parameter | Description
----------|------------
signalfx_api_token | Your SignalFx API Token
dimension_list | Set custom dimensions on all of the metrics that collectd sends to SignalFx. For example, you can use a custom dimension to indicate that one of your servers is running Kafka by including it in the hash map as follows: dimension_list => {"serverType" => "kafka"}
aws_integration | Controls AWS metadata syncing to SignalFx. Default is true.
signalfx_api_endpoint | The API endpoint to post your metrics. This will be useful if you are using a proxy.
ensure_signalfx_collectd_version | Ensures the collectd version on the system. Accepted values are of `ensure` from Puppet.
signalfx_collectd_repo_source | The source of the collectd repository from SignalFx. This will be useful when you mirror a SignalFx repository. Valid on Ubuntu and Debian systems.
signalfx_plugin_repo_source  | The source of the signalfx-collectd-plugin repository from SignalFx. This will be useful when you mirror a SignalFx repository. Valid on Ubuntu and Debian systems.
fqdnlookup | Fqdnlookup of the collectd.conf file
hostname | Hostname to be used if fqdnlookup is true, default value would be the hostname from Puppet Facter.
interval | Interval of the collectd.conf file
timeout | Timeout of the collectd.conf file
read_threads | ReadThreads of the collectd.conf file
write_queue_limit_high | WriteQueueLimitHigh of the collectd.conf file
write_queue_limit_low | WriteQueueLimitLow of the collectd.conf file
collect_internal_stats | CollectInternalStats of the collectd.conf file
log_file | The location of log file to be used by collectd
write_http_timeout | Timeout option of write_http plugin
write_http_buffersize | BufferSize option of write_http plugin
write_http_flush_interval | FlushInterval option of write_http plugin
write_http_log_http_error | LogHttpError option of write_http plugin
ensure_signalfx_plugin_version | Ensures the signalfx-collectd-plugin version on the system. Accepted values are of `ensure` from Puppet.
signalfx_plugin_log_traces | LogTraces of signalfx-collectd-plugin
signalfx_plugin_interactive | Interactive option of signalfx-collectd-plugin
signalfx_plugin_notifications | Notifications option of signalfx-collectd-plugin
signalfx_plugin_notify_level | NotifyLevel option of signalfx-collectd-plugin
signalfx_plugin_dpm | DPM option of signalfx-collectd-plugin

You can also install and configure different collectd plugins

### Apache
```shell
class { 'configure_collectd_plugins::plugins::apache':
  instanceName  => 'myapacheinstance',
  url           => 'http://localhost/mod_status?auto'
}
```

Parameter | Description
----------|------------
instanceName | Appears as the dimension `plugin_instance` in SignalFx. 
url | The URL at which the plugin can read the output of Apache's mod_status module.

### MySQL
```shell
class { 'configure_collectd_plugins::plugins::mysql':
  hostname,
  user,
  password,
  database
}
```

Parameter | Description
----------|------------
hostname | Name of the host on which MySQL is running.
user | Username that collectd can use to connect to MySQL.
password | Password that collectd can use to connect to MySQL.
database | Name of the MySQL database to monitor. 


### Elasticsearch
```shell
class { 'configure_collectd_plugins::plugins::elasticsearch':
  clustername           => 'elasticsearch',
  indexes               => '_all',
  enable_index_stats    => true,
  enable_cluster_health => true
}
```

Parameter | Description
----------|------------
clustername | Appears as the dimension `plugin_instance` in SignalFx. 
indexes | Indexes to monitor using this plugin. All indexes are monitored by default.
enable_index_stats | Enable or disable index statistic collection.
enable_cluster_health | Enable/disable index and cluster health stats.

### RabbitMQ
```shell
class { 'collectd::plugins::rabbitmq' :
      username,
      password,
      host,
      port,
      collect_channels     = true,
      collect_connections  = true,
      collect_exchanges    = true,
      collect_nodes        = true,
      collect_queues       = true,
      http_timeout         = 'UNSET',
      verbosity_level      = 'UNSET',
      field_length         = 1024
    }
```

Parameter | Description
----------|------------
username | Username for authentication
password | Password for authentication
host | hostname or IP address of the RabbitMQ server running the RabbitMQ Management Plugin
port | Port of the RabbitMQ Management API
collect_channels | Enables collection of channel statistics
collect_connections | Enables collection of connection statistics
collect_exchanges | Enables collection of exchange statistics
collect_nodes | Enables collection of node statistics
collect_queues | Enables collection of queue statistics
http_timeout | Integer value in seconds before timing out when connecting to the RabbitMQ Management API. Default is 60.
verbosity_level | Controls the quantity of RabbitMQ metrics collected. see [plugin file](https://github.com/signalfx/puppet_install_collectd/blob/master/templates/plugins/rabbitmq/rabbitmq.conf.erb) for more details. If unspecified, 'info' will be used.
field_length | The number of characters used to encode dimension data. Default is 1024.



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

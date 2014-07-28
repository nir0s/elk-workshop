elk-workshop
============

A logging workshop backed by the ELK Trio.

# Provisioner

The vagrant directory contains a Vagrantfile that provisions a machine with:

* Elasticsearch
* Elasticsearch-head plugin
* Logstash
* Kibana
* pylog
* Nginx
* RabbitMQ

# Box

The Vagrantfile in the root directory will load a box created from the above provisioned machine.

# Resources

The resources directory contains:

* An apache dashboard for Kibana.
* A logstash configuration file.
* An Nginx config file which exposes Kibana in port 3000 and ES in 9200.

# Generating Logs during the workshop

[pylog](pylog.readthedocs.org) generates random logs which you can use during the workshop.

Please refer to the documentation to understand how to use it.
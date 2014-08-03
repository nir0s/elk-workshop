elk-workshop
============

A logging workshop backed by the ELK Trio.

# Requirements

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](http://www.vagrantup.com/)

# Provisioner

The vagrant directory contains a Vagrantfile that provisions a machine with:

* [Elasticsearch](http://www.elasticsearch.org/overview/elasticsearch)
* [Elasticsearch-head plugin](http://mobz.github.io/elasticsearch-head/)
* [Logstash](http://www.elasticsearch.org/overview/logstash)
* [Kibana](http://www.elasticsearch.org/overview/kibana)
* [feeder](http://feeder.readthedocs.org)
* [Nginx](http://nginx.com/)
* [RabbitMQ](http://www.rabbitmq.com/)

# Box

The Vagrantfile in the root directory will load a box created from the above provisioned machine.

# Resources

The resources directory contains:

* An apache dashboard for Kibana. [Link](https://gist.github.com/jordansissel/9698373)
* A logstash configuration file.
* An Nginx config file which exposes Kibana in port 3000 and ES in 9200.

# Generating Logs during the workshop

[feeder](http://github.com/nir0s/feeder) generates random logs which you can use during the workshop.

Please refer to the [documentation](http://feeder.readthedocs.org) to understand how to use it.
elk-workshop
============

A logging workshop backed by the ELK Trio.

# Requirements

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](http://www.vagrantup.com/)

# Vagrant

## Provisioner

The vagrant directory contains a Vagrantfile that provisions a machine with:

* [Elasticsearch](http://www.elasticsearch.org/overview/elasticsearch)
* [Elasticsearch-head plugin](http://mobz.github.io/elasticsearch-head/)
* [Elasticsearch-kopf plugin](https://github.com/lmenezes/elasticsearch-kopf)
* [Logstash](http://www.elasticsearch.org/overview/logstash)
* [Kibana](http://www.elasticsearch.org/overview/kibana)
* [feeder](http://feeder.readthedocs.org)
* [Nginx](http://nginx.com/)
* [RabbitMQ](http://www.rabbitmq.com/)

## Box

The Vagrantfile in the root directory will load a box created from the above provisioned machine.

# Resources

The resources directory contains:

* An apache dashboard for Kibana. [Link](https://gist.github.com/jordansissel/9698373)
* A logstash configuration file.
* An Nginx config file which exposes Kibana in port 3000 and ES in 9200.

# Generating Logs during the workshop

[feeder](http://github.com/nir0s/feeder) generates random logs which you can use during the workshop.

For instance, from the ~/elk-workshop directory, run:

```bash
mouth feed -f ApacheAccess -t File -m 1000 -g 0.001 -b 200
```

This will write an ApacheAccessEx log, to a file in the current directory called generated.log.

Please refer to the [documentation](http://feeder.readthedocs.org) to understand how to use it.

# Running logstash

```bash
~/elk/logstash/bin/logstash -f ~/elk-workshop/resources/logstash.conf
```
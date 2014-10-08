elk-workshop
============

A logging workshop backed by the ELK Trio.

# Presentation

a workshop.html is supplied backed by reveal.js
It is also available at http://slides.com/nir0s/elk-workshop#/

# Requirements

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](http://www.vagrantup.com/)

# Vagrant

## Provisioner

The vagrant directory contains a Vagrantfile that provisions a machine with:

* [Elasticsearch](http://www.elasticsearch.org/overview/elasticsearch)
* [Elasticsearch-head plugin](http://mobz.github.io/elasticsearch-head/)
* [Elasticsearch-kopf plugin](https://github.com/lmenezes/elasticsearch-kopf)
* [Elasticsearch-bigdesk plugin](http://bigdesk.org)
* [Logstash](http://www.elasticsearch.org/overview/logstash)
* [Kibana](http://www.elasticsearch.org/overview/kibana)
* [feeder](http://feeder.readthedocs.org)
* [RabbitMQ](http://www.rabbitmq.com/)

## Box

The [Vagrantfile](https://github.com/nir0s/elk-workshop/blob/master/Vagrantfile) in the root directory will load a box created from the above provisioned machine.

To get started run:

```bash
vagrant box add <box_url> --name elk
# then, from the same dir
vagrant up
# and then
vagrant ssh
```

# Resources

The resources directory contains:

* A logstash configuration file.

# Running logstash

```bash
~/elk/logstash/bin/logstash -f ~/elk-workshop/resources/logstash.conf
```

alternatively, run:

```bash
~/elk-workshop/runls.sh
```

# Generating Logs during the workshop

[feeder](http://github.com/nir0s/feeder) generates random logs which you can use during the workshop.

For instance, from the ~/elk-workshop directory, run:

```bash
mouth feed -f ApacheAccessEx -t File -m 1000 -g 0.001
```

This will write Apache Extended Access logs to a file called generated.log in the current directory.

Please refer to the [documentation](http://feeder.readthedocs.org) to understand how to use feeder.

# Web Access

* To access the Kibana dashboard, please go to [http://11.0.1.7:5601/index.html#/dashboard/file/logstash.json](http://11.0.1.7:5601/index.html#/dashboard/file/logstash.json).
* To access the Head dashboard, please go to [http://11.0.1.7:9200/_plugin/head](http://11.0.1.7:9200/_plugin/head).
* To access the Kopf dashboard, please go to [http://11.0.1.7:9200/_plugin/kopf](http://11.0.1.7:9200/_plugin/kopf).
* To access the BigDesk dashboard, please go to [http://11.0.1.7:9200/_plugin/bigdesk](http://11.0.1.7:9200/_plugin/bigdesk).

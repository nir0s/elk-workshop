# flake8: NOQA
# IMPORTANT: run "feeder list fake" to see the list of fake data types that can be generated.

GENERATOR = {
    'transports': {
        'test_amqp': {
            'type': 'AMQP',
            'host': 'localhost',
            'queue': 'logstash',
            'exchange': '',
            'routing_key': 'logstash',
            'delivery_mode': 2,
        },
    },
}
# JMeter 5.0
Dockerized jmeter with ElasticsearchBackendListener for live logging.

## Plugins
```
- jpgc-dummy-0.2
- jpgc-casutg-2.6
```

## Elasticsearch 6.x
https://github.com/test-stack/elasticSearchBackendListenerClient
```
ElasticsearchBackendListener
```

## How to run
```
docker run --rm --name jmeter -v /path/to/tests/:/opt/tests/ jmeter:latest /opt/apache-jmeter-5.0/bin/jmeter.sh -n -t /opt/tests/TestPlan.jmx -l /opt/tests/results.jtl -j /opt/tests/test.log
```

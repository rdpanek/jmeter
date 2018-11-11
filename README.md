# JMeter 5.0
Dockerized JMeter with ElasticsearchBackendListener for live logging.

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
docker run -it --rm -v `pwd`:/jmeter rdpanek/jmeter:latest --nongui --testfile testplan.jmx --logfile result.jtl
```

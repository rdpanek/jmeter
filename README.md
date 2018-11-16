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

## How to run as NON-GUI
### Run without Docker
> jmeter -Jserver.rmi.ssl.disable=true --nongui --testfile testPlan.jmx

### Run as interactive
```
docker run -it --rm -v `pwd`:/jmeter rdpanek/jmeter:latest --nongui --testfile testplan.jmx --logfile result.jtl
```
### Run as detached
```
docker run --detach --rm -v `pwd`:/jmeter rdpanek/jmeter:latest --nongui --testfile testplan.jmx --logfile result.jtl
```
### Run as server
```
docker run --name generator2 --detach --publish 1099:1099 --rm rdpanek/jmeter:latest -Jserver.rmi.ssl.disable=true -Djava.rmi.server.hostname=192.168.1.202 -Jserver.rmi.localport=1099 -Dserver_port=1099 --server
```
### Connect to server
```
docker run -it --rm --volume `pwd`:/jmeter rdpanek/jmeter:latest -Jserver.rmi.ssl.disable=true --nongui --testfile testPlan.jmx --remotestart 192.168.1.202:1098 --logfile result.jtl
```

### Generate report after test end
```
docker run --name controller --detach --rm --volume `pwd`:/jmeter rdpanek/jmeter:latest -Jserver.rmi.ssl.disable=true --nongui --testfile SeleniumGridJmeter5.jmx  --logfile result.jtl --forceDeleteResultFile --reportatendofloadtests --reportoutputfolder report -Jjmeter.reportgenerator.overall_granularity=1000
```

# JMeter 5.0 r1840935
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
> jmeter --nongui --testfile testPlan.jmx

### Run as interactive
```
docker run --name jmeter -it --rm -v `pwd`:/jmeter rdpanek/jmeter:latest jmeter --nongui --testfile testplan.jmx --logfile result.jtl
```
### Run as detached
```
docker run --name jmeter --detach --rm -v `pwd`:/jmeter rdpanek/jmeter:latest jmeter --nongui --testfile testplan.jmx --logfile result.jtl
```

### Run as specify USER
```
docker run --name jmeter -it --rm -v `pwd`:/jmeter --user $(id -u):$(id -g) rdpanek/jmeter:latest jmeter --nongui --testfile testPlans.jmx --logfile result.jtl
```

### Run with log to stdout
```
docker run --name jmeter -it --rm -v `pwd`:/jmeter rdpanek/jmeter:latest jmeter --nongui --testfile testPlans.jmx -j /dev/stdout
```

### Run as server / generator
```
docker run --name generator1 --detach --publish 1098:1098 --rm rdpanek/jmeter:latest jmeter -Jserver.rmi.ssl.disable=true -Djava.rmi.server.hostname=192.168.1.202 -Jserver.rmi.localport=1098 -Dserver_port=1098 --server
```
>Stopping a server after the end of the test It's possible add this option
`-Jserver.exitaftertest=true`
### Connect to generator
```
docker run --name controller -it --rm --volume `pwd`:/jmeter rdpanek/jmeter:latest jmeter -Jserver.rmi.ssl.disable=true --nongui --testfile testPlan.jmx --remotestart 192.168.1.202:1098,192.168.1.202:1099 --logfile result.jtl
```

### Generate HTML report after test end
Go to [Documentation](https://jmeter.apache.org/usermanual/generating-dashboard.html)
```
docker run --name controller --detach --rm --volume `pwd`:/jmeter rdpanek/jmeter:latest jmeter -Jserver.rmi.ssl.disable=true --nongui --testfile testPlan.jmx --logfile result.jtl --forceDeleteResultFile --reportatendofloadtests --reportoutputfolder report   -Jjmeter.reportgenerator.overall_granularity=1000
```

## 13. Remote Testing with JMeter
Go to [Documentation](https://jmeter.apache.org/usermanual/remote-test.html)
- Management of multiple JMeterEngines from a single machine
- No need to copy the test plan to each server - the client sends it to all the servers

> **Important** The same test plan is run by all the servers. JMeter does not distribute the load between servers, each runs the full test plan. So if you set 1000 Threads and have 6 JMeter server, you end up injecting 6000 Threads.

> **Warning** Remote mode does use more resources in client. It's reason what JMeter use Stripped mode. Check always JMeter client resources, that is not overloaded.

### Configure nodes

All nodes ( client and servers )
- are running exactly the same version of JMeter
- are using the same version of Java on all systems. Using different versions of Java may work but is discouraged.
- copy of dataProvider ( e.g. csv ) with test-data must be on each JMeter server.
Advantage is, that each generator can work with unique test-data.

### Start the servers / generators

- On all servers run JMeter in remote node `--server`
- Note that there can only be one JMeter server on each node unless different RMI ports are used.
- By default, RMI uses dynamic ports for the JMeter server engine. This can cause problems for firewalls, so you can define the JMeter property `server.rmi.localport` to control this port numbers.
- command line option for specify the remote hosts to us is `--remotestart`. Multiple servers can bbe added, comma-delimited.

### Environment variables
- HEAP `"-JXms2g -JXmx2g -JX:MaxMetaspaceSize=500m"`
- GC_ALGO
JVM garbage collector options. Defaults to `-XX:+UseG1GC -XX:MaxGCPauseMillis=250 -XX:G1ReservePercent=20`

> Get the list of ip addresses `docker inspect --format '{{ .Name }} => {{ .NetworkSettings.IPAddress }}' $(docker ps -a -q)`

## Docker Compose
> Define a run multiple containers

- For JMeter distributed load testing, we need run 1 master and N slave containers.

# Useful links

- [Running a Docker container as a non-root user](https://medium.com/redbubble/running-a-docker-container-as-a-non-root-user-7d2e00f8ee15)
- [Running Your Images as a Non-Root User](https://github.com/openshift-evangelists/openshift-workshops/blob/master/modules/run-as-non-root.adoc)

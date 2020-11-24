#!/bin/bash -e

# start jmeter
echo $(date) 'start non-gui JMeter distrib tests'
$JMETER_HOME/bin/jmeter -Jserver.rmi.ssl.disable=true --nongui --testfile demoTestPlan.jmx --remotestart generator1:1098,generator2:1098 --logfile result.jtl
echo $(date) 'stop JMeter'
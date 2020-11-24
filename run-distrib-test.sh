#!/bin/bash -e

# start jmeter
echo $(date) 'start non-gui JMeter distrib tests'
$JMETER_HOME/bin/jmeter -Jserver.rmi.ssl.disable=true --nongui --testfile $TEST_PLAN_NAME --remotestart $GENERATORS --logfile result.jtl
echo $(date) 'stop JMeter'
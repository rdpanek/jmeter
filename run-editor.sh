#!/bin/bash -e

# start jmeter
echo $(date) 'start JMeter'
$JMETER_HOME/bin/jmeter
echo $(date) 'stop JMeter'
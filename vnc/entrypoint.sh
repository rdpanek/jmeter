#!/bin/bash

# setup git
export GIT_TRACE=0

#git config --global credential.helper '!aws codecommit credential-helper $@'
#git config --global credential.UseHttpPath true
#cd $GIT_TESTS_PATH
#git clone $GIT_TESTS
#ls -lah $GIT_TESTS_PATH

# select version of test by revision or branch name
#( cd ${GIT_TESTS_PATH}/performancetesting && git fetch && git checkout $GIT_REVISION )

# run VNC
vncserver -geometry $VNC_RESOLUTION -depth $VNC_COL_DEPTH :1

sleep 10

#start JMeter and tail logs
/opt/apache-jmeter-5.3/bin/jmeter
cd $JMETER_HOME/logs/ && touch jmeter.log
tail -f /opt/app-root/src/.vnc/*.log #-f $SMARTMETER_HOME/logs/*.log


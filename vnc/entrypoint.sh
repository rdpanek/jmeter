#!/bin/bash

# start JMeter
echo $(date) 'start JMeter container'


# setup git
export GIT_TRACE=0

git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
cd $JMETER_HOME && mkdir tests
git clone $GIT_REPOSITORY tests
ls -lah ${JMETER_HOME}/tests

# select version of test by revision or branch name
( cd ${JMETER_HOME}/tests && git fetch && git checkout $GIT_REVISION )

# run VNC
echo $(date) 'start VNC server'
touch /opt/app-root/src/.Xauthority
vncserver -geometry $VNC_RESOLUTION -depth $VNC_COL_DEPTH :1
sleep 10

# open terminals
xterm -geometry 93x21+0+0 -bg black -fg white -title 'Available Resources' -e 'htop' &
xterm -geometry 93x21+583+0 -bg black -fg white -title 'Disk Space Usage' -hold -e 'df -h' &

# tail logs
touch $JMETER_HOME/jmeter.log
tail -f /opt/app-root/src/.vnc/*.log -f $JMETER_HOME/*.log
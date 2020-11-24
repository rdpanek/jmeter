FROM rdpanek/jmeter:5.3.0

LABEL io.k8s.description="VNC Container based on Ubuntu" \
    io.k8s.display-name="VNC Container based on Ubuntu" \
    io.openshift.expose-services="5901:xvnc" \
    io.openshift.tags="vnc, ubuntu, xfce" \
    io.openshift.non-scalable=true

ENV DISPLAY=:1 \
    VNC_PORT=5901 

EXPOSE $VNC_PORT

### Envrionment config
ENV USER=root \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x1024 \
    VNC_PW=secret

### Install dependencies
RUN yum -y install epel-release && \
    yum groupinstall "Xfce" -y && \
    yum -y install tigervnc-server tigervnc-server-minimal && \
    yum clean all

### Setup VNC
ADD ./vnc/scripts/xstartup /opt
RUN mkdir ~/.vnc && \
    PASSWD_PATH=~/.vnc/passwd && \
    echo $VNC_PW | vncpasswd -f >> $PASSWD_PATH && \
    chmod 600 $PASSWD_PATH && \
    mv /opt/xstartup ~/.vnc/xstartup && \
    chmod +x ~/.vnc/xstartup

### Install additional components
RUN yum -y install xterm htop vim && \
    yum clean all

COPY ./vnc/entrypoint.sh /
COPY README.md /opt/app-root/src/Desktop/
COPY run-editor.sh /opt/app-root/src/Desktop/
COPY run-distrib-test.sh /opt/app-root/src/Desktop/
COPY curl-format.txt /
COPY demoTestPlan.jmx $JMETER_HOME
RUN chmod +x /entrypoint.sh

WORKDIR $JMETER_HOME
ENTRYPOINT ["/entrypoint.sh"]
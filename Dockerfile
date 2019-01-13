# About my dockerfile

FROM openshift/base-centos7
LABEL maintainer="rdpanek@gmail.com"

ENV JMETER_VERSION apache-jmeter-5.0
ENV MIRROR_LINK https://www-eu.apache.org/dist//jmeter/binaries/${JMETER_VERSION}.tgz
ENV JMETER_HOME /opt/${JMETER_VERSION}
ENV JMETER_TEMP_PLUGINS ${JMETER_HOME}/plugins
ENV JMETER_LIB ${JMETER_HOME}/lib
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV ELASTIC_PLUGIN_LINK https://raw.githubusercontent.com/test-stack/elasticSearchBackendListenerClient/master/install.sh

ENV PATH $PATH:$JMETER_BIN
STOPSIGNAL SIGKILL

# Install JMeter
RUN yum install -y \
		java-1.8.0-openjdk \
		java-1.8.0-openjdk-devel \
		curl \
		unzip && \
		yum clean all && \
		#
		cd /opt/ && \
		curl -L -O ${MIRROR_LINK} && \
		tar -xzf ${JMETER_VERSION}.tgz && rm -rf ${JMETER_VERSION}.tgz && \
		# Install JMeter Plugins
		mkdir ${JMETER_TEMP_PLUGINS} && cd ${JMETER_TEMP_PLUGINS} && \
		curl -L -O https://jmeter-plugins.org/files/packages/jpgc-dummy-0.2.zip && \
		unzip -o -d ${JMETER_TEMP_PLUGINS} jpgc-dummy-0.2.zip && \
		curl -L -O https://jmeter-plugins.org/files/packages/jpgc-casutg-2.6.zip && \
		unzip -o -d ${JMETER_TEMP_PLUGINS} jpgc-casutg-2.6.zip && \
		# Copy plugins to jmeter enviroment
		cp lib/*.jar ${JMETER_LIB}/ && \
		cp lib/ext/*.jar ${JMETER_LIB}/ext/ && \
		rm -rf ${JMETER_TEMP_PLUGINS} && \
		# Install ElasticSearchBackendListenerClient
		cd ${JMETER_LIB} && \
		curl -L -o install.sh https://raw.githubusercontent.com/test-stack/elasticSearchBackendListenerClient/master/install.sh && \
		chmod +x install.sh && ./install.sh && \
		cd ${JMETER_LIB} && rm -rf install.sh && \
		jmeter --version && \
		#
		mkdir /jmeter && \
		adduser jmeter && usermod -aG jmeter jmeter && \
		chown jmeter:jmeter /jmeter

ENV JAVA_HOME /etc/alternatives/jre

WORKDIR /jmeter
ENTRYPOINT ["jmeter"]
CMD ["--?"]

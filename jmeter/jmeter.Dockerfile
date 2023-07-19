# inspired by https://github.com/hauptmedia/docker-jmeter  and
# https://github.com/hhcordero/docker-jmeter-server/blob/master/Dockerfile


FROM python:3.11.0 AS build
LABEL MAINTAINER = "HRM Dev Team"

USER root

#================================================================================================================================================================================
# Environment variables
#================================================================================================================================================================================
# defined some environment variables
#================================================================================================================================================================================
ARG JMETER_VERSION="5.5"
ARG JDK_VERSION="11"
ENV JMETER_HOME /jmeter/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN ${JMETER_HOME}/bin
ENV MIRROR_HOST http://archive.apache.org/dist/jmeter
ENV	JMETER_DOWNLOAD_URL  ${MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_DOWNLOAD_URL http://repo1.maven.org/maven2/kg/apc
ENV JMETER_PLUGINS_FOLDER=${JMETER_HOME}/lib/ext
ENV DISPLAY=:99


#================================================================================================================================================================================
# JDK
#================================================================================================================================================================================
# download and install jdk
#================================================================================================================================================================================
RUN apt-get update && \
    apt-get install -y openjdk-${JDK_VERSION}-jre-headless && \
    apt-get clean
# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f
# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64/
RUN export JAVA_HOME

#================================================================================================================================================================================
# Jmeter & Dependencies
#================================================================================================================================================================================
# download and extract jmeter and dependencies
#================================================================================================================================================================================
RUN mkdir /jmeter
WORKDIR /jmeter
RUN  mkdir -p /tmp/dependencies  \
	&& curl -v -L ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /jmeter \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /jmeter  \
	&& rm -rf /tmp/dependencies
#RUN curl -v -L ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-dummy/0.2/jmeter-plugins-dummy-0.2.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-dummy-0.2.jar

#================================================================================================================================================================================
# Google Chrome
#================================================================================================================================================================================
# can specify versions by CHROME_VERSION
#  e.g. google-chrome-stable=53.0.2785.101-1
#       google-chrome-beta=53.0.2785.92-1
#       google-chrome-unstable=54.0.2840.14-1
#       latest (equivalent to google-chrome-stable)
#       google-chrome-beta  (pull latest beta)
#================================================================================================================================================================================
ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    ${CHROME_VERSION:-google-chrome-stable} \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
  
#================================================================================================================================================================================
# Chrome webdriver
#================================================================================================================================================================================
# can specify versions by CHROME_DRIVER_VERSION
# Latest released version will be used by default
#================================================================================================================================================================================
ARG CHROME_DRIVER_VERSION
RUN if [ -z "$CHROME_DRIVER_VERSION" ]; \
  then CHROME_MAJOR_VERSION=$(google-chrome --version | sed -E "s/.* ([0-9]+)(\.[0-9]+){3}.*/\1/") \
    && NO_SUCH_KEY=$(curl -ls https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION} | head -n 1 | grep -oe NoSuchKey) ; \
    if [ -n "$NO_SUCH_KEY" ]; then \
      echo "No Chromedriver for version $CHROME_MAJOR_VERSION. Use previous major version instead" \
      && CHROME_MAJOR_VERSION=$(expr $CHROME_MAJOR_VERSION - 1); \
    fi ; \
    CHROME_DRIVER_VERSION=$(wget --no-verbose -O - "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION}"); \
  fi \
  && echo "Using chromedriver version: "$CHROME_DRIVER_VERSION \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /chromedriver \
  && rm /tmp/chromedriver_linux64.zip \
  && chmod 755 /chromedriver/chromedriver \
  && ln -fs /chromedriver/chromedriver /usr/bin/chromedriver
  
#================================================================================================================================================================================
# Chrome & Chrome webdriver
#================================================================================================================================================================================
# Check chrome version
#================================================================================================================================================================================
RUN echo "Chrome: " && google-chrome --version
RUN echo "Chrome driver: " && /chromedriver/chromedriver --version

#================================================================================================================================================================================
# Dos2unix
#================================================================================================================================================================================
#  download, extract and install dos2unix
#================================================================================================================================================================================
RUN apt-get update && \
    apt-get install dos2unix && \
    apt-get clean

#================================================================================================================================================================================
# Jmeter launch & load tests excute
#================================================================================================================================================================================
# Entrypoint has same signature as "jmeter" command
# Set global PATH such that "jmeter" command is found
# Add JMeter to the Path
# Set JMeter Home
#================================================================================================================================================================================
ENV PATH $PATH:$JMETER_BIN


COPY --chmod=0755 /jmeter/*.sh /
COPY --chmod=0755 /jmeter/bin/ ${JMETER_HOME}/bin
COPY --chmod=0755 /jmeter/lib/ ${JMETER_HOME}/lib

RUN mkdir ${JMETER_HOME}/testOrder
RUN mkdir ${JMETER_HOME}/testOrder/uka-connect
RUN mkdir ${JMETER_HOME}/testOrder/uka-connect/testcases
RUN mkdir ${JMETER_HOME}/testOrder/uka-connect/testresult
RUN touch incidentProcessing.jtl

RUN mkdir ${JMETER_HOME}/testOrder/masterdata-hub
RUN mkdir ${JMETER_HOME}/testOrder/masterdata-hub/testcases
RUN mkdir ${JMETER_HOME}/testOrder/masterdata-hub/testresult
RUN touch dataProcessing.jtl

COPY jmeter/testOrder/uka-connect/testcases/incidentProcessing.jmx ${JMETER_HOME}/testOrder/uka-connect/testcases

WORKDIR	${JMETER_HOME}

RUN dos2unix -b /run.sh
ENTRYPOINT ["/run.sh"]
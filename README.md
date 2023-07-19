<h1 align="center"><img src="https://jmeter.apache.org/images/logo.svg" alt="Apache JMeter logo" /></h1>

An Open Source Java application designed to measure performance and load test applications.

By The Apache Software Foundation

[![Build Status](https://api.travis-ci.com/apache/jmeter.svg?branch=master)](https://travis-ci.com/apache/jmeter/)
[![codecov](https://codecov.io/gh/apache/jmeter/branch/master/graph/badge.svg)](https://codecov.io/gh/apache/jmeter)
[![License](https://img.shields.io/:license-apache-brightgreen.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Stack Overflow](https://img.shields.io/:stack%20overflow-jmeter-brightgreen.svg)](https://stackoverflow.com/questions/tagged/jmeter)
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/org.apache.jmeter/ApacheJMeter/badge.svg)](https://maven-badges.herokuapp.com/maven-central/org.apache.jmeter/ApacheJMeter)
[![Javadocs](https://www.javadoc.io/badge/org.apache.jmeter/ApacheJMeter_core.svg)](https://www.javadoc.io/doc/org.apache.jmeter/ApacheJMeter_core)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/apache/jmeter.svg?style=social)](https://twitter.com/intent/tweet?text=Powerful%20load%20testing%20with%20Apache%20JMeter:&url=https://jmeter.apache.org)

## What Is It?

Apache JMeter can measure performance and load test static and dynamic web applications.

It can be used to simulate a heavy load on a server, group of servers,
network or object to test its strength or to analyze overall performance under different load types.

![JMeter screen](https://raw.githubusercontent.com/apache/jmeter/master/xdocs/images/screenshots/jmeter_screen.png)

## Features

Complete portability and 100% Java.

Multi-threading allows concurrent sampling by many threads and
simultaneous sampling of different functions by separate thread groups.

### Protocols

Ability to load and performance test many applications/server/protocol types:

- Web - HTTP, HTTPS (Java, NodeJS, PHP, ASP.NET,...)
- SOAP / REST Webservices
- FTP
- Database via JDBC
- LDAP
- Message-oriented Middleware (MOM) via JMS
- Mail - SMTP(S), POP3(S) and IMAP(S)
- Native commands or shell scripts
- TCP
- Java Objects

### IDE

Fully featured Test IDE that allows fast Test Plan **recording**
 (from Browsers or native applications), **building** and **debugging**.

### Command Line

[Command-line mode (Non GUI / headless mode)](https://jmeter.apache.org/usermanual/get-started.html#non_gui)
to load test from any Java compatible OS (Linux, Windows, Mac OSX, ...)

### Reporting

A complete and ready to present [dynamic HTML report](https://jmeter.apache.org/usermanual/generating-dashboard.html)

![Dashboard screenshot](https://raw.githubusercontent.com/apache/jmeter/master/xdocs/images/screenshots/dashboard/response_time_percentiles_over_time.png)

[Live reporting](https://jmeter.apache.org/usermanual/realtime-results.html)
into 3rd party databases like InfluxDB or Graphite

![Live report](https://raw.githubusercontent.com/apache/jmeter/master/xdocs/images/screenshots/grafana_dashboard.png)

### Correlation

Easy correlation through ability to extract data from most popular response formats,
[HTML](https://jmeter.apache.org/usermanual/component_reference.html#CSS/JQuery_Extractor),
[JSON](https://jmeter.apache.org/usermanual/component_reference.html#JSON_Extractor),
[XML](https://jmeter.apache.org/usermanual/component_reference.html#XPath_Extractor) or
[any textual format](https://jmeter.apache.org/usermanual/component_reference.html#Regular_Expression_Extractor)

### Highly Extensible Core

- Pluggable Samplers allow unlimited testing capabilities.
- **Scriptable Samplers** (JSR223-compatible languages like Groovy).
- Several load statistics can be chosen with **pluggable tiers**.
- Data analysis and **visualization plugins** allow great extensibility and personalization.
- Functions can be used to provide dynamic input to a test or provide data manipulation.
- Easy Continuous Integration via 3rd party Open Source libraries for Maven, Gradle and Jenkins.

## The Latest Version

Details of the latest version can be found on the
[JMeter Apache Project web site](https://jmeter.apache.org/)

## Requirements

The following requirements exist for running Apache JMeter:

- Java Interpreter:

  A fully compliant Java 8 Runtime Environment is required
  for Apache JMeter to execute. A JDK with `keytool` utility is better suited
  for Recording HTTPS websites.

- Optional jars:

  Some jars are not included with JMeter.
  If required, these should be downloaded and placed in the lib directory
  - JDBC - available from the database supplier
  - JMS - available from the JMS provider
  - [Bouncy Castle](https://www.bouncycastle.org/) -
  only needed for SMIME Assertion

- Java Compiler (*OPTIONAL*):

  A Java compiler is not needed since the distribution includes a
  precompiled Java binary archive.
  > **Note** that a compiler is required to build plugins for Apache JMeter.

## Installation Instructions

> **Note** that spaces in directory names can cause problems.

- Release builds

  Unpack the binary archive into a suitable directory structure.

## Running JMeter

1. Change to the `bin` directory
2. Run the `jmeter` (Un\*x) or `jmeter.bat` (Windows) file.

### Windows

For Windows, there are also some other scripts which you can drag-and-drop
a JMX file onto:

- `jmeter-n.cmd` - runs the file as a non-GUI test
- `jmeter-n-r.cmd` - runs the file as a non-GUI remote (client-server) test
- `jmeter-t.cmd` - loads the file ready to run it as a GUI test

## Documentation

The documentation available as of the date of this release is
also included, in HTML format, in the [printable_docs](printable_docs) directory,
and it may be browsed starting from the file called [index.html](printable_docs/index.html).

## Reporting a bug/enhancement

See [Issue Tracking](https://jmeter.apache.org/issues.html).

## Licensing and Legal Information

For legal and licensing information, please see the following files:

- [LICENSE](LICENSE)
- [NOTICE](NOTICE)

## Influxdb

**still in progress...**

## Grafana

**still in progress...**
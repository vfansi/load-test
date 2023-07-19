#!/bin/bash

BASEDIR=$(dirname $0)
ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

echo ""
echo "Script location: ${BASEDIR}"
echo "1: ${ABSPATH}"
echo "2: ${ABSDIR}"

echo ""
echo ""	
echo "Delete all existing and unused docker images and container ...."
echo ""
echo ""	

	docker system prune -f
	docker image rm -f influxdb &&  docker buildx prune -f
	docker image rm -f grafana  &&  docker buildx prune -f
	docker image rm -f jmeter   &&  docker buildx prune -f
	docker rm $(docker kill $(docker ps -aq))

echo ""
echo ""	
echo "The docker network created if no exits ..."
echo ""
echo ""	

docker network rm load-test
docker network create load-test

echo ""
echo ""	
echo "The docker container 'influxdb' is starting right now ..."
echo ""
echo ""	

 	docker build -t influxdb -f ${BASEDIR}/influxdb/Dockerfile . && \ 
 	docker run -d --net=load-test -p 8086:8086 \
	-e DOCKER_INFLUXDB_INIT_MODE=setup \
	-e DOCKER_INFLUXDB_INIT_USERNAME=vafa \
	-e DOCKER_INFLUXDB_INIT_PASSWORD=Sogeti2023 \
	-e DOCKER_INFLUXDB_INIT_ORG=hrm \
	-e DOCKER_INFLUXDB_INIT_BUCKET=jmeter \
	-e DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=HIEgznlrVfZDzNMPCW_LnaKrSw2LXpGtK9Pehpw5r_jefI88RmW8Kv8R7fCgGxAC6gENGscBMizyYJn3TzPOmg== \
    influxdb

echo ""
echo ""	  
echo "The docker container 'grafana' is starting right now ..."
echo ""
echo ""	
sleep 2

 	docker build -t grafana -f ${BASEDIR}/grafana/Dockerfile . && \
 	docker run -d --net=load-test -p 3000:3000 grafana

echo ""
echo ""
echo "Copy all config files (jar, bat, ...) to directory 'jmeter/bin' "
echo ""
echo ""

cp -arf ${ABSDIR}/jmeter/bin/configOrder/* ${ABSDIR}/jmeter/bin/


eval ${ABSDIR}/jmeter/launch-tests.sh


#sleep 3

#echo ""
#echo ""
#echo "Grafana Dashboard is opened now"

#start "" microsoft-edge:http://localhost:3000/d/fdcd96ac-0aac-4316-b559-4e0b4fe96d9d/hrm-systems-ag-uka-connect-performance-testing?orgId=1&refresh=5s

#sleep 5

#echo ""
#echo ""
#echo "Tests running now ..."


# Keep entrypoint simple: we must pass the standard JMeter arguments
#T_DIR_CONNECT=${BASEDIR}/testOrder/uka-connect
#T_DIR_MASTERDATA_HUB=${BASEDIR}/testOrder/masterdata-hub

#TEST_CASES_DIR_CONNECT=${T_DIR_CONNECT}/testcases
#TEST_CASES_CASE_DIR_MASTERDATA_HUB=${T_DIR_MASTERDATA_HUB}/testcases

#RESULT_DIR_CONNECT=${T_DIR_CONNECT}/testresult
#RESULT_DIR_MASTERDATA_HUB=${T_DIR_MASTERDATA_HUB}/testresult

#REPORT_DIR_CONNECT=${T_DIR_CONNECT}/testreport
#REPORT_DIR_MASTERDATA_HUB=${T_DIR_MASTERDATA_HUB}/testreport

# Reporting dir: start fresh

#rm -rf ${REPORT_DIR_CONNECT} > /dev/null 2>&1
#rm -rf ${REPORT_DIR_MASTERDATA_HUB} > /dev/null 2>&1

#mkdir -p ${REPORT_DIR_CONNECT}
#mkdir -p ${REPORT_DIR_MASTERDATA_HUB}


#rm -rf ${RESULT_DIR_CONNECT}/incidentProcessing.jtl > /dev/null 2>&1
#rm -rf ${RESULT_DIR_MASTERDATA_HUB}/dataProcessing.jtl > /dev/null 2>&1

# Example build line
#docker buildx prune -f && docker build -t jmeter -f ${BASEDIR}/jmeter/jmeter.Dockerfile . && docker ps -l && docker run -d --net=load-test --mount type=bind,source="/${ABSDIR}/jmeter/bin",target="/jmeter/apache-jmeter-5.5/bin" \
jmeter -n -t ${TEST_CASES_DIR_CONNECT}/incidentProcessing.jmx -l ${RESULT_DIR_CONNECT}/incidentProcessing.jtl -j ${T_DIR_CONNECT}/jmeter.log \
-e -o ${REPORT_DIR_CONNECT} 

#&& docker cp $(docker ps -n 1 --format '{{.ID}}'):/jmeter/apache-jmeter-5.5/${REPORT_DIR_CONNECT} /${ABSDIR}/jmeter
#start "" /${ABSDIR}/jmeter/testreport/index.html
       			   
sleep 120
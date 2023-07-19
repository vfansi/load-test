#!/bin/bash

BASEDIR=$(dirname $0)
ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

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
echo "The docker container 'jmeter' is starting right now ..."
echo ""
echo ""	

T_DIR_CONNECT=testOrder/uka-connect
#T_DIR_MASTERDATA_HUB=testOrder/masterdata-hub
TEST_CASES_DIR_CONNECT=${T_DIR_CONNECT}/testcases
#TEST_CASES_CASE_DIR_MASTERDATA_HUB=${T_DIR_MASTERDATA_HUB}/testcases
RESULT_DIR_CONNECT=${T_DIR_CONNECT}/testresult
#RESULT_DIR_MASTERDATA_HUB=${T_DIR_MASTERDATA_HUB}/testresult
REPORT_DIR_CONNECT=${T_DIR_CONNECT}/testreport
#REPORT_DIR_MASTERDATA_HUB=${T_DIR_MASTERDATA_HUB}/testreport

# Reporting dir: start fresh

rm -rf ${REPORT_DIR_CONNECT} > /dev/null 2>&1
#rm -rf ${REPORT_DIR_MASTERDATA_HUB} > /dev/null 2>&1
mkdir -p ${REPORT_DIR_CONNECT}
#mkdir -p ${REPORT_DIR_MASTERDATA_HUB}
rm -rf ${RESULT_DIR_CONNECT}/incidentProcessing.jtl ${T_DIR_CONNECT}/jmeter.log > /dev/null 2>&1
#rm -rf ${RESULT_DIR_MASTERDATA_HUB}/dataProcessing.jtl > /dev/null 2>&1

docker buildx prune -f && docker build -t jmeter . && docker ps -n 1 && docker run --mount type=bind,source="/${ABSDIR}/bin",target="/jmeter/apache-jmeter-5.5/bin" \
jmeter -n -t ${TEST_CASES_DIR_CONNECT}/incidentProcessing_linux.jmx -JChromeDriverPath=/chromedriver/chromedriver -DataCSVPath=${RESULT_DIR_CONNECT}/IncidentData.csv -l ${RESULT_DIR_CONNECT}/incidentProcessing.jtl -j ${T_DIR_CONNECT}/jmeter.log \
-e -o ${REPORT_DIR_CONNECT} && docker cp $(docker ps -n 1 --format '{{.ID}}'):/jmeter/apache-jmeter-5.5/${REPORT_DIR_CONNECT} /${ABSDIR}

start "" /${ABSDIR}/testreport/index.html

sleep 120
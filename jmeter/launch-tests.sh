#!/bin/bash

# Keep entrypoint simple: we must pass the standard JMeter arguments

BASEDIR=$(dirname $0)
T_DIR_CONNECT=${BASEDIR}/testOrder/uka-connect
#T_DIR_MASTERDATA_HUB=${BASEDIR}/testOrder/masterdata-hub
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
rm -rf ${RESULT_DIR_CONNECT}/incidentProcessing.jtl > /dev/null 2>&1
#rm -rf ${RESULT_DIR_MASTERDATA_HUB}/dataProcessing.jtl > /dev/null 2>&1

sleep 3

echo ""
echo ""
echo "Grafana Dashboard is opened now"
echo ""
echo ""

start "" microsoft-edge:http://localhost:3000/d/fdcd96ac-0aac-4316-b559-4e0b4fe96d9d/hrm-systems-ag-uka-connect-performance-testing?orgId=1&refresh=5s

sleep 5

echo ""
echo ""
echo "Tests running now ..."
echo ""
echo ""

${BASEDIR}/bin/jmeter.sh -n -t ${TEST_CASES_DIR_CONNECT}/incidentProcessing.jmx -JChromeDriverPath=${BASEDIR}/bin/chromedriver/chromedriver.exe -DataCSVPath=${RESULT_DIR_CONNECT}/IncidentData.csv -l ${RESULT_DIR_CONNECT}/incidentProcessing.jtl -j ${T_DIR_CONNECT}/jmeter.log \
-e -o ${REPORT_DIR_CONNECT}

echo ""
echo ""
echo "HTML Report Results is opened"
echo ""
echo ""

start "" ${REPORT_DIR_CONNECT}/index.html

sleep 120
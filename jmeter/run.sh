#!/bin/sh

# Execute JMeter command
set -e 
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`

s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))

export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

# Keep entrypoint simple: we must pass the standard JMeter arguments
# Reporting dir: start fresh
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

bin/jmeter -v
bin/jmeter -n -t ${TEST_CASES_DIR_CONNECT}/incidentProcessing.jmx -JChromeDriverPath=/chromedriver/chromedriver -DataCSVPath=${RESULT_DIR_CONNECT}/IncidentData.csv -l ${RESULT_DIR_CONNECT}/incidentProcessing.jtl -j ${T_DIR_CONNECT}/jmeter.log \
-e -o ${REPORT_DIR_CONNECT}
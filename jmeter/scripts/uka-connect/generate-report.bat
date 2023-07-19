RD /S /Q C:\lasttest\testOrder\uka-connect\testresult
RD /S /Q C:\lasttest\testOrder\uka-connect\testreport
MD C:\lasttest\testOrder\uka-connect\testresult
MD C:\lasttest\testOrder\uka-connect\testreport
C:\lasttest\bin\jmeter.bat -n -t C:\lasttest\testOrder\uka-connect\testcases\incidentProcessing.jmx -l C:\lasttest\testOrder\uka-connect\testresult\incidentProcessing.jtl -e -o C:\lasttest\testOrder\uka-connect\testreport
START "" "C:\lasttest\testOrder\masterdata-hub\testreport\index.html"
pause
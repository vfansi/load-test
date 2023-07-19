RD /S /Q C:\lasttest\testOrder\masterdata-hub\testresult
RD /S /Q C:\lasttest\testOrder\masterdata-hub\testreport
MD C:\lasttest\testOrder\masterdata-hub\testresult
MD C:\lasttest\testOrder\masterdata-hub\testreport
C:\lasttest\bin\jmeter.bat -n -t C:\lasttest\testOrder\masterdata-hub\testcases\dataProcessing.jmx -l C:\lasttest\testOrder\masterdata-hub\testresult\DatatProcessing.jtl -e -o C:\lasttest\testOrder\masterdata-hub\testreport
START "" "C:\lasttest\testOrder\masterdata-hub\testreport\index.html"
pause
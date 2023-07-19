@ECHO ==========================================================================
@ECHO JMETER HTML REPORT
@ECHO VERSION: 0.0.1
@ECHO AUTHOR:  UKA CONNECT TEAM
@ECHO COMPANY: HRM SYSTEMS AG
@ECHO ==========================================================================

@ECHO OFF
TITLE Run Jmeter performance Tests


TASKLIST | FIND /i "mmc.exe" && TASKKILL /im mmc.exe /F   || CALL:ECHOBACKGROUNDCOLOR Red "Process 'mmc.exe' has already been started and is currently running."
ECHO.
ECHO.

TASKLIST | FIND /i "vmmem.exe" && TASKKILL /im vmmem.exe /F   || CALL:ECHOBACKGROUNDCOLOR Red "Process 'vmmem.exe' has already been started and is currently running."
ECHO.
ECHO.

TASKLIST | FIND /i "RuntimeBroker.exe" && TASKKILL /im RuntimeBroker.exe /F   || CALL:ECHOBACKGROUNDCOLOR Red "Process 'RuntimeBroker.exe' has already been started and is currently running."
ECHO.
ECHO.

TASKLIST | FIND /i "chrome.exe" && TASKKILL /im chrome.exe /F   || CALL:ECHOBACKGROUNDCOLOR Red "Process 'chrome.exe' has already been started and is currently running."
ECHO.
ECHO.

TASKLIST | FIND /i "httpd.exe" && TASKKILL /im httpd.exe /F   || CALL:ECHOBACKGROUNDCOLOR Red "Process 'httpd.exe' has already been started and is currently running."
ECHO.
ECHO.

TASKLIST | FIND /i "msedge.exe" && TASKKILL /im msedge.exe /F   || CALL:ECHOBACKGROUNDCOLOR Red "Process 'msedge.exe' has already been started and is currently running."
ECHO.
ECHO.

TASKLIST | FIND /i "java.exe" && TASKKILL /im java.exe /F || CALL:ECHOBACKGROUNDCOLOR Red "Process 'startAgent' has already been started and is currently running."
ECHO.
ECHO.

cd "C:\dev\tools\influxdb"
cmd.exe /c START /min influxd
PING -n 6 127.0.0.1 > nul
ECHO.
ECHO.
CALL:ECHOBACKGROUNDCOLOR Green "The service 'influxdb' is starting right now ..."
TIMEOUT /t 10 /nobreak

cd "C:\dev\tools\grafana\bin"
cmd.exe /c START /min grafana-server
ECHO.
ECHO.
CALL:ECHOBACKGROUNDCOLOR Green "The service 'grafana' is starting right now ..."
TIMEOUT /t 5 /nobreak

ECHO.
ECHO.
CALL:ECHOBACKGROUNDCOLOR Green "Grafana Dashboard is opened now"
SET url="http://localhost:3000/d/fdcd96ac-0aac-4316-b559-4e0b4fe96d9d/hrm-systems-ag-uka-connect-performance-testing?orgId=1&refresh=5s"
START microsoft-edge:%url%

CALL "C:\lasttest\scripts\uka-connect\generate-report.bat"
ECHO.
ECHO.

CALL:ECHOBACKGROUNDCOLOR Green "HTML Report Results is opened"
ECHO.
ECHO.
CD C:\lasttest\testOrder\uka-connect\testreport
START index.html

if errorlevel 1 goto CONTINUE
exit /b 0

:CONTINUE
cmd /k
exit /b 1

:ECHOCOLORTEXT
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %1 %2
goto:eof

:ECHOBACKGROUNDCOLOR
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -backgroundcolor %1 %2
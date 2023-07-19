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

cd "C:\dev\tools\ServerAgent-2.2.3\ServerAgent-2.2.3"
cmd.exe /c START /min startAgent.bat
ECHO.
ECHO.
CALL:ECHOBACKGROUNDCOLOR Green "The service 'ServerAgent' is starting right now ..."
TIMEOUT /t 10 /nobreak


CALL "C:\lasttest\scripts\masterdata-hub\generate-report.bat"
ECHO.
ECHO.

CALL:ECHOBACKGROUNDCOLOR Green "HTML Report Results is opened"
ECHO.
ECHO.
CD C:\lasttest\testOrder\masterdata-hub\testreport
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
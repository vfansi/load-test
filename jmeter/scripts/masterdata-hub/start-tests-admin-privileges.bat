@echo off
title Detect and run file with Admin privileges

set yourFile=start-services-and-tests.bat
set privileges=no

VER | FINDSTR /IL "6.2." > NUL
IF %ERRORLEVEL% EQU 0 (
SET winVersion=8
SET privileges=yes
)

VER | FINDSTR /IL "6.1." > NUL
IF %ERRORLEVEL% EQU 0 (
SET winVersion=7
SET privileges=yes
)

VER | FINDSTR /IL "6.0." > NUL
IF %ERRORLEVEL% EQU 0 (
SET winVersion=Vista
SET privileges=yes
)

if "%privileges%"=="no" goto SkipElevation
If "%privileges%"=="yes" goto Elevation

:SkipElevation
call %CD%\%yourFile%
goto End

:Elevation
PushD "%~dp0"
If Exist "%~0.ELEVATED" Del /f "%~0.ELEVATED"

Set CMD_Args=%0 %*
Set CMD_Args=%CMD_Args:"=\"%
Set ELEVATED_CMD=PowerShell -Command (New-Object -com 'Shell.Application').ShellExecute('%yourFile%', '/%cd:~0,1% %CMD_Args%', '', 'runas')
Echo %ELEVATED_CMD% >> "%~0.ELEVATED"
call %ELEVATED_CMD%

Del /f "%~0.ELEVATED"
goto End

:End
Echo ----------------------------
Echo All done!
goto EOF
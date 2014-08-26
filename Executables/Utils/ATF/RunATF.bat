@echo off

color 7
set appPath="%~dp0ATF.exe"
set excelPath="%~dp0TestSuite.xls"
set pri=%1
set debug=%2
set teeAppPath="%~dp0LocalTools\tee.exe"
cd /d "%~dp0"
%appPath% %excelPath% %pri% %debug%| %teeAppPath% "%~dp0ATF_Log.txt"
echo.
if not exist "%~dp0ATF_Fail_Result.txt" ( echo ATF Run Done With PASS Result.
exit /B 0) else (
color c
echo ATF Run Done With FAIL Result.
exit /B 1)
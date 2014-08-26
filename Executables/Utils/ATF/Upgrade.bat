@echo off
cd /d %~dp0
set oriRootPath="D:\ATF"
set updateRootPath=%~dp0

echo Upgrading ATF Framework Files To Version 1.8...
copy %~dp0ATF.exe %oriRootPath% /Y
copy %~dp0RunATF.bat %oriRootPath% /Y
copy %~dp0TestCaseUpgrade.xlsm %oriRootPath% /Y
copy %~dp0LocalTools\TestReport.xsl %oriRootPath%\LocalTools /Y
copy %~dp0LocalTools\TestReport_Sum.xsl %oriRootPath%\LocalTools /Y
copy %~dp0LocalTools\PerfTestReport.xsl %oriRootPath%\LocalTools /Y
copy %~dp0LocalTools\plink.exe %oriRootPath%\LocalTools /Y
copy %~dp0LocalTools\psftp.exe %oriRootPath%\LocalTools /Y
echo Upgraded Done...
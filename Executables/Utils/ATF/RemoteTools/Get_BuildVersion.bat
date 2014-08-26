@echo off
set scriptPath=D:\TestAutomation\RemoteTools
set errorLogPath=D:\TestAutomation\ErrorLog
set buildPath=D:\STCaseFile\ATF.exe
set outputPath=D:\TestAutomation\Output
if not exist %errorLogPath% mkdir %errorLogPath%
if not exist %outputPath% mkdir %outputPath%
if exist %buildPath% (echo Checking build version...
%scriptPath%\BuildVersion.exe %buildPath% FileVersion > %outputPath%\buildversion.txt
echo Current Test Build Version is :
type %outputPath%\buildversion.txt
) else (
echo Check build version error! >> "%errorLogPath%\CheckBuildVersionError.log"
echo Check build version error!
exit)
)

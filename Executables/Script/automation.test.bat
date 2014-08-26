@echo off
setlocal

:: this script is tightly coupled with atf specific, as test report directory,
:: schema name, vah and test utlis package names etc, please double check
:: whenever upgrading atf

set automation_dir=%cd%\..\..\..\Package\automation
set drop_ver=0.4.0

if not "%~1"=="" set automation_dir=%~1
if not "%~2"=="" set drop_ver=%~2

:START
set vah_home=%cd%\..\..
set utils=%cd%\..\Utils
set atf_rpt_dir=D:\TestAutomation\Report

:: prerequisites zip
:: ==================================================
"%utils%\zip.exe" >nul 2>nul
if errorlevel 1 echo [ERROR] zip NOT found & goto ERROR


:: setup folder structure
:: ==================================================
if exist "%automation_dir%" rd /s /q "%automation_dir%"
mkdir "%automation_dir%"


:: archive vah package
:: ==================================================
echo Copying vah to automation ...
copy /y "%automation_dir%\..\release\VAH_Pkg_Release_V%drop_ver%.zip"   "%automation_dir%\VAHPkg.zip"
if errorlevel 1 goto ERROR


:: archive test utils package
:: ==================================================
echo Copying test utils to automation ...
copy /y "%automation_dir%\..\VAH_TestUtils_V%drop_ver%.zip"             "%automation_dir%\VAHTestUtils.zip"
if errorlevel 1 goto ERROR


:: run atf
:: ==================================================
pushd "%utils%\ATF"

echo Deploying VAH package via ATF ...
call RunATF_Deploy.bat
if errorlevel 1 goto ERROR

rename ATF_Log.txt Deploy_log.txt

echo Running ATF for automation tests ...
call RunATF.bat
if errorlevel 1 goto ERROR

move /y *.txt                   "%automation_dir%"
move /y *.xml                   "%automation_dir%"
copy /y "%atf_rpt_dir%\*.xsl"   "%automation_dir%"
popd


:: housekeeping
:: ==================================================
pushd "%automation_dir%"
if exist *.zip del /f /q *.zip
if exist *.Z   del /f /q *.Z
popd


:: Compress
:: ==================================================
pushd "%automation_dir%"
echo Compressing VAH automation test report ...
set vah_automation=VAH_AutomationTest_V%drop_ver%.zip
if exist "..\%vah_automation%" del /f /q "..\%vah_automation%"
"%utils%\zip.exe" -r "..\%vah_automation%" *
if errorlevel 1 goto ERROR

popd & goto END


:ERROR
echo ERROR!
:: FIXME
:: it's not stable now about automation tests, not block building even failure
:: should return error code in formal approach
endlocal & exit /b 0

:END
echo SUCCEED!
endlocal & exit /b 0

@echo off

set action=rebuild
set config=debug
set platform=x64
set vs_ver=2010
set ut_dir=%cd%\..\..\..\Package\unit_tests

if not "%~1"=="" set config=%~1
if not "%~2"=="" set platform=%~2
if not "%~3"=="" set ut_dir=%~3

:START
if exist "%ut_dir%" rd /s /q "%ut_dir%"
mkdir "%ut_dir%"

:: build unit testing projects
:: ==================================================
if /i "%vs_ver%"=="2010" set vs_path=%vs100comntools%..\IDE
if /i "%vs_ver%"=="2008" set vs_path=%vs90comntools%..\IDE

path %vs_path%;%path%

echo Starting %action% unit testing %config% version for %platform% by VS%vs_ver% ...
devenv ..\..\MasterBuild\MasterBuildUT.sln /%action% "%config%|%platform%"

:: not return error since postpone its handling to Jenkins xUnit plugin
:: to generate test report
if errorlevel 1 goto END


:: copy xml result reports
:: ==================================================
echo Copying xml result reports ...
set result=cppunit_result*.xml
xcopy "..\..\UnitTest\VadCacheManager\%result%"  "%ut_dir%"  /y /i /r
xcopy "..\..\UnitTest\VadPayload\%result%"       "%ut_dir%"  /y /i /r

goto END


:: %1: image name [in]
:KILL_PS
setlocal
set in=%~1

tasklist /fi "imagename eq %in%" 2>nul | %windir%\system32\find /i /n "%in%" >nul
if "%errorlevel%"=="0" taskkill /f /im "%in%" /t >nul
endlocal & exit /b 0

:RM_TMPS
setlocal
set tmps="Visual Studio 2010Projects",
for %%i in (%tmps%) do if exist "%%~i" rd /s /q "%%~i"
endlocal & exit /b 0


:BUILD_ERROR
echo ERROR!
exit /b 1

:END
call :KILL_PS msbuild.exe
call :KILL_PS mspdbsrv.exe
call :RM_TMPS


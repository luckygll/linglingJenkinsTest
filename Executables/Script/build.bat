@echo off

set action=build
set config=debug
set platform=x64
set vs_ver=2010

if not "%~1"=="" set action=%~1
if not "%~2"=="" set config=%~2
if not "%~3"=="" set platform=%~3
if not "%~4"=="" set vs_ver=%~4

if /i "%vs_ver%"=="2010" set vs_path=%vs100comntools%..\IDE
if /i "%vs_ver%"=="2008" set vs_path=%vs90comntools%..\IDE

path %vs_path%;%path%


echo.
echo Starting %action% %config% version for %platform% by VS%vs_ver% ...
echo.

devenv ..\..\MasterBuild\MasterBuild.sln /%action% "%config%|%platform%"
if errorlevel 1 goto BUILD_ERROR
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


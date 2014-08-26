@echo off
setlocal ENABLEDELAYEDEXPANSION

rem * It is supposed the VAH full package will be created firstly everytime the pcn package
rem * should be created. 
rem * Input param: FPKG_DIR: the work dir of creating the VAH full package.
rem * Input param: WORK_DIR: the dir under which the PCN .Z and .zip files will be created.
rem * Input param: PCN_VER: the version number of current PCN.

set FPKG_DIR=C:\Temp\VAH
set WORK_DIR=C:\Temp\PCN
set PCN_VER=0-0-3
set BUILDVERSION=01

if not "%~1"=="" set FPKG_DIR=%~1
if not "%~2"=="" set WORK_DIR=%~2
if not "%~3"=="" set PCN_VER=%~3
if not "%~4"=="" set BUILDVERSION=%~4

:START
echo Starting packaging the VAH-PCN

set PATCH_LIST=filelist.txt

pushd %~dp0
set CUR_DIR=%cd%
set utils=%cd%\..\Utils
popd

rem check VAH full package folder
if not exist %FPKG_DIR% (
	echo. Not found the VAH full package path
	goto error
)

pushd %FPKG_DIR%

rem clear the folder
if exist "%WORK_DIR%" rd /s /q "%WORK_DIR%"
mkdir %WORK_DIR%

rem copy the patch list
if not exist %CUR_DIR%\%PATCH_LIST% (
	echo. Not found the patch list file ... 
	goto error
)
echo. COPY the patch list file...
copy /y %CUR_DIR%\%PATCH_LIST% %WORK_DIR%

rem copy the install batch
if not exist %CUR_DIR%\vahpcninstall.bat (
	echo. Not found the vahpcninstall.bat ... 
	goto error
)
echo. COPY vahpcninstall.bat...
copy /y %CUR_DIR%\vahpcninstall.bat %WORK_DIR%

rem copy the uninstall batch
if not exist %CUR_DIR%\vahpcnuninstall.bat (
	echo. Not found the vahpcnuninstall.bat ... 
	goto error
)
echo. COPY vahpcnuninstall.bat
copy /y %CUR_DIR%\vahpcnuninstall.bat %WORK_DIR%

rem copy patch files from full package path to work dir
echo. COPY the patch files...
for /f "delims=: " %%I in (%CUR_DIR%\%PATCH_LIST%) do (
	echo.   COPY %FPKG_DIR%\%%~I 
	echo.     TO %WORK_DIR% 
	copy /y %%~dpI%%~nxI %WORK_DIR%
)

popd

:: SPB
:: ==================================================
echo. Generating SPB package ...
set spb_ver=%PCN_VER%

echo. generating spb: %utils%\SPBGen
"%utils%\SPBGen\SPBGen.exe" -i:DDS -c:VAA -n:VAH-PCN -o:Win-2008-64 -v:%spb_ver% -a:install -b:%BUILDVERSION% -S:"%WORK_DIR%" -D:"D:\ThomsonReuters\tmp\vah\pcn" -X:"vahpcninstall.bat" -U:"vahpcnuninstall.bat" -O:"%WORK_DIR%\.." -V:"Thomson Reuters" -G:DDS
if errorlevel 1 goto ERROR

:: Compress
:: ==================================================
pushd %WORK_DIR%
echo.
echo. Compressing VAH-PCN ZIP package ...
set vah_pcn_pkg=..\VAH-PCN_Pkg_V%spb_ver%.zip

if exist "%vah_pcn_pkg%" del /f /q "%vah_pcn_pkg%"
"%utils%\zip.exe" -r "%vah_pcn_pkg%" * vahpcninstall.bat vahpcnuninstall.bat
if errorlevel 1 goto ERROR
popd

goto END

:ERROR
echo ERROR!
endlocal & exit /b 1

:END
echo SUCCEED!
endlocal & exit /b 0

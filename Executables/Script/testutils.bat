@echo off
setlocal

set config=release
set platform=x64
set testutils_dir=%cd%\..\..\..\Package\testutils
set drop_ver=0.4.0

if not "%~1"=="" set testutils_dir=%~1
if not "%~2"=="" set drop_ver=%~2

:START
set vah_home=%cd%\..\..
set utils=%cd%\..\Utils

:: prerequisites zip
:: ==================================================
"%utils%\zip.exe" >nul 2>nul
if errorlevel 1 echo [ERROR] zip NOT found & goto ERROR


:: setup folder structure
:: ==================================================
if exist "%testutils_dir%" rd /s /q "%testutils_dir%"
mkdir "%testutils_dir%\smfvahtesttool\bin"
mkdir "%testutils_dir%\smfvahtesttool\doc"
mkdir "%testutils_dir%\VAH_Harness"
mkdir "%testutils_dir%\samplevaa\bin"
mkdir "%testutils_dir%\samplevaa\pdb"


:: smf vah test tool
:: ==================================================
echo Copying smf vah test tool to testutils ...
svn export --force "..\Utils\smfvahtesttool\executable\%config%"    "%testutils_dir%\smfvahtesttool\bin"
if errorlevel 1 echo [WARNING]: smf vah test tool NOT export

xcopy "..\Utils\smfvahtesttool\manual\*.pdf"                        "%testutils_dir%\smfvahtesttool\doc"    /y /i /r
xcopy "..\Utils\smfvahtesttool\manual\*.txt"                        "%testutils_dir%\smfvahtesttool\doc"    /y /i /r


:: vah harness
:: ==================================================
echo Copying vah harness to testutils ...
svn export --force "..\Utils\VAH_Harness"                           "%testutils_dir%\VAH_Harness"
if errorlevel 1 echo [WARNING]: vah harness NOT export


:: schema converter
:: ==================================================
echo Copying schema converter to testutils ...
svn export --force "..\Utils\SchemaConverter"                       "%testutils_dir%\SchemaConverter"
if errorlevel 1 echo [WARNING]: schema converter NOT export


:: sample vaa
:: ==================================================
echo Copying sample VAAs to testutils ...
pushd "%vah_home%\SDK\samples\Build.out.%platform%"
xcopy "Binary\%config%\*.dll"                                       "%testutils_dir%\samplevaa\bin"         /y /i /r
xcopy "Pdb\%config%\*.pdb"                                          "%testutils_dir%\samplevaa\pdb"         /y /i /r
popd

echo Copying sample VAAs config to testutils...
set vaa_config_dir=%testutils_dir%\samplevaa\config
setlocal EnableDelayedExpansion
pushd "%vah_home%\SDK\samples"
for /f %%i in ('dir conf /a /b /s') do (
@echo %%i
set _orgpath=%%i
set _newpath=%vaa_config_dir%!_orgpath:%cd%=!
mkdir !_newpath! >nul 2>nul
xcopy "!_orgpath!\*.*"   "!_newpath!"  /y /e /i /r
)
popd
endlocal
if errorlevel 1 echo [WARNING]: Sample VAAs build results NOT found


:: Compress
:: ==================================================
pushd "%testutils_dir%"
echo Compressing VAH testutils ...
set vah_utils=VAH_TestUtils_V%drop_ver%.zip
if exist "..\%vah_utils%" del /f /q "..\%vah_utils%"
"%utils%\zip.exe" -r "..\%vah_utils%" *
if errorlevel 1 goto ERROR

popd & goto END


:ERROR
echo ERROR!
:: it's not mandatory for test utils, not block building even failure
endlocal & exit /b 0

:END
echo SUCCEED!
endlocal & exit /b 0

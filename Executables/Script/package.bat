@echo off
setlocal

set config=debug
set platform=x64
set working_directory=D:\ThomsonReuters\VAH
set drop_ver=0.4.0
set buildversion=01

if not "%~1"=="" set config=%~1
if not "%~2"=="" set platform=%~2
if not "%~3"=="" set working_directory=%~3
if not "%~4"=="" set drop_ver=%~4
if not "%~5"=="" set buildversion=%~5

:START
set vah_home=%cd%\..\..
set utils=%cd%\..\Utils

:: prerequisites qf and zip
:: ==================================================
set quantum >nul 2>nul
if errorlevel 1 echo [ERROR] QF NOT setup  & goto ERROR
"%utils%\zip.exe" >nul 2>nul
if errorlevel 1 echo [ERROR] zip NOT found & goto ERROR


:: setup folder structure
:: ==================================================
if exist "%working_directory%" rd /s /q "%working_directory%"
mkdir "%working_directory%\Bin"
mkdir "%working_directory%\Config"
mkdir "%working_directory%\Pdb"
mkdir "%working_directory%\QF"
mkdir "%working_directory%\Script"
rem mkdir "%working_directory%\3rdParty\Adfin\Bin"
rem mkdir "%working_directory%\3rdParty\Adfin\Config"
mkdir "%working_directory%\Utils"

pushd "%vah_home%"

:: Bin
:: ==================================================
echo Copying binary files of VAH ...
xcopy "Build.out.%platform%\Binary\%config%\*.dll"			"%working_directory%\Bin"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Executables\Utils\VAHTEditor.exe"					"%working_directory%\Bin"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Build.out.%platform%\Binary\%config%\CfgSync.exe"	"%working_directory%\Bin"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Build.out.%platform%\Binary\%config%\PreInstallCheck.exe"	"%working_directory%\Bin"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Executables\Utils\procdump.exe"          			"%working_directory%\Bin"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Build.out.%platform%\Binary\%config%\Scheduler.exe"	"%working_directory%\Bin"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Build.out.%platform%\Binary\%config%\vadreader.exe"	"%working_directory%\Bin"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Executables\FMSAPI\%config%\%platform%\*.dll"        "%working_directory%\Bin"       /y /i /r
if errorlevel 1 goto ERROR
:: Config
:: ==================================================
echo Copying config files of VAH ...
xcopy "Data\*"                                              "%working_directory%\Config"    /y /i /r /e
if errorlevel 1 goto ERROR

if exist "%working_directory%\Config\Manifest.xml" del /f /q "%working_directory%\Config\Manifest.xml"
if errorlevel 1 goto ERROR

xcopy "%QUANTUM_FRAMEWORK_DIR%\Data\Framework Events.xml"       "%working_directory%\Config"    /y /i /r
if errorlevel 1 goto ERROR


:: Pdb
:: ==================================================
echo Copying pdb files of VAH ...
xcopy "Build.out.%platform%\pdb\%config%\*.pdb"									"%working_directory%\Pdb"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Build.out.%platform%\Binary\%config%\PreInstallCheck.pdb"				"%working_directory%\Pdb"       /y /i /r
if errorlevel 1 goto ERROR
xcopy "Build.out.%platform%\Binary\%config%\CfgSync.pdb"						"%working_directory%\Pdb"       /y /i /r
if errorlevel 1 goto ERROR
if /i "%config%"=="Debug" xcopy "%QUANTUM_FRAMEWORK_DIR%\Libs\SCW\VC100\%platform%\%config%\SCWClientd.pdb"		"%working_directory%\Pdb"   /y /i /r
if errorlevel 1 goto ERROR
if /i "%config%"=="Release" xcopy "%QUANTUM_FRAMEWORK_DIR%\Libs\SCW\VC100\%platform%\%config%\SCWClient.pdb"	"%working_directory%\Pdb"   /y /i /r
if errorlevel 1 goto ERROR
xcopy "%QUANTUM_FRAMEWORK_DIR%\Build.out.dotnet\Release\QuantumAnalyser.pdb"	"%working_directory%\Pdb"       /y /i /r
if errorlevel 1 echo [WARNING] NOT found QuantumAnalyser.pdb under %QUANTUM_FRAMEWORK_DIR%\Build.out.dotnet\Release

:: QF
:: ==================================================
echo Copying binary files of QF ...
xcopy "%QUANTUM_FRAMEWORK_DIR%\Build.out.%platform%\Binary\%config%\*.dll"              "%working_directory%\QF"                            /y /i /r
if errorlevel 1 goto ERROR
xcopy "%QUANTUM_FRAMEWORK_DIR%\Build.out.%platform%\pdb\%config%\*.pdb"                 "%working_directory%\Pdb"                           /y /i /r
if errorlevel 1 goto ERROR
copy "%QUANTUM_FRAMEWORK_DIR%\Build.out.%platform%\Binary\%config%\WinLauncher.exe"     "%working_directory%\QF"                            /y
if errorlevel 1 goto ERROR
copy "%QUANTUM_FRAMEWORK_DIR%\Build.out.%platform%\Binary\%config%\WinLauncher.exe"     "%working_directory%\QF\QuantumStatsCollator.exe"   /y
if errorlevel 1 goto ERROR
copy "%QUANTUM_FRAMEWORK_DIR%\Build.out.%platform%\Binary\%config%\QuantumMonitor.exe"  "%working_directory%\QF"                            /y
if errorlevel 1 goto ERROR
copy  "%QUANTUM_FRAMEWORK_DIR%\Build.out.dotnet\Release\QuantumAnalyser.exe"            "%working_directory%\QF"                            /y
if errorlevel 1 echo [WARNING] NOT found QuantumAnalyser.exe under %QUANTUM_FRAMEWORK_DIR%\Build.out.dotnet\Release

:: remove SMF DLLs by using SMF server ones directly
set smf_dlls_pattern=*msc*smf*.dll
if exist "%working_directory%\QF\%smf_dlls_pattern%" del /f /q "%working_directory%\QF\%smf_dlls_pattern%"


:: Script
:: ==================================================
echo Copying script files of VAH ...
copy /y "Executables\Script\run.bat"              "%working_directory%\Script"

:: Script for FMSService
:: This script for copy FMSServer IP configuration from Manifest file
copy /y "Executables\Script\replace.pl"              "%working_directory%\Script"
xcopy /y "Executables\Utils\perl"                       "%working_directory%\Utils"
xcopy /y "Executables\Utils\md5.exe"                       "%working_directory%\Utils"
xcopy /y "Executables\Utils\nvspbind.exe"                       "%working_directory%\Utils"
if errorlevel 1 goto ERROR


:: 3rdParty
:: ==================================================
echo Copying 3rdParty files of VAH ...
rem svn export --force "Executables\Utils\Adfin\x64\Release" "%working_directory%\3rdParty\Adfin\Bin"
rem svn export --force "Executables\Utils\Adfin\x64\Config"  "%working_directory%\3rdParty\Adfin\Config"
rem if errorlevel 1 goto ERROR


:: SCW
:: ==================================================
echo Copying SCW ...
svn export --force "Executables\Utils\SCW"        "%working_directory%\..\SCW"
if errorlevel 1 goto ERROR

:: FMSClient
:: ==================================================
echo Copying FMSClient ...
xcopy "Executables\FMSClient\bin\Release\x64\*.dll" "%working_directory%\..\FMSClient\Bin\Release\x64" /I /Y
xcopy "Executables\FMSClient\bin\Release\x64\*.exe" "%working_directory%\..\FMSClient\Bin\Release\x64" /I /Y
xcopy "Executables\FMSClient\bin\Release\x64\*.bat" "%working_directory%\..\FMSClient\Bin\Release\x64" /I /Y
xcopy "Executables\FMSClient\config\*.dat" "%working_directory%\..\FMSClient\Config" /I /Y
xcopy "Executables\FMSClient\doc\*.txt" "%working_directory%\..\FMSClient\doc" /I /Y
xcopy "Executables\Script\StartFMSClient.bat" "%working_directory%\..\FMSClient\Script\" /I /Y
::xcopy "Executables\Script\fmsclient_install.bat" "%working_directory%\..\FMSClient\Script\" /I /Y
::xcopy "Executables\Script\fmsclient_uninstall.bat" "%working_directory%\..\FMSClient\Script\" /I /Y
xcopy "Executables\Script\replace.pl" "%working_directory%\..\FMSClient\Script\" /I /Y
xcopy "Executables\Utils\perl\*" "%working_directory%\..\FMSClient\Utils\" /I /Y
xcopy "Data\PRIVATE.DAT"     "%working_directory%\..\FMSClient\Config" /I /Y
if errorlevel 1 goto ERROR
:: Installation facilities
:: ==================================================
copy /y "Executables\Script\vahinstall.bat"          "%working_directory%\.."
if errorlevel 1 goto ERROR
copy /y "Executables\Script\vahuninstall.bat"        "%working_directory%\.."
if errorlevel 1 goto ERROR


popd

if /i "%working_directory%"=="D:\ThomsonReuters\VAH" goto END


:: SPB(none for debug version)
:: ==================================================
echo Generating SPMove package ...

set drop_ver_log=%~n0_%drop_ver%.log
set spb_ver=%drop_ver%
echo %drop_ver%>"%drop_ver_log%"
for /f "tokens=1-3 delims=." %%i in (%drop_ver_log%) do set spb_ver=%%i-%%j-%%k
del /f /q "%drop_ver_log%"

if /i "%config%"=="Release" (

"%utils%\SPBGen\SPBGen.exe" -i:DDS -c:VAA -n:VAH -o:Win-2008-64 -v:%spb_ver% -a:install -b:%buildversion% -S:"%working_directory%\.." -D:"D:\ThomsonReuters\tmp\vah" -X:"vahinstall.bat" -U:"vahuninstall.bat" -O:"%working_directory%\.." -G:DDS
if errorlevel 1 goto ERROR
)

:: Compress
:: ==================================================
pushd "%working_directory%\.."

echo Compressing VAH package ...
set vah_pkg=VAH_Pkg_%config%_V%drop_ver%.zip
if exist "%vah_pkg%" del /f /q "%vah_pkg%"
"%utils%\zip.exe" -r "%vah_pkg%" VAH\* SCW\* FMSClient\* vahinstall.bat vahuninstall.bat
if errorlevel 1 goto ERROR

popd & goto END


:ERROR
echo ERROR!
endlocal & exit /b 1

:END
echo SUCCEED!
endlocal & exit /b 0

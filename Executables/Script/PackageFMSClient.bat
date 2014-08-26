@echo on
@echo Packaging FMSClient
@echo off 
setlocal
:START
set vah_home=%cd%\..\..
set utils=%cd%\..\Utils
set drop_ver=1.5.0

set config=release
set platform=x64
set working_directory=D:\ThomsonReuters
set drop_ver=1.5.0

if not "%~1"=="" set config=%~1
if not "%~2"=="" set platform=%~2
if not "%~3"=="" set working_directory=%~3
if not "%~4"=="" set drop_ver=%~4
if exist "%working_directory%\FMSClient" rd /s /q "%working_directory%\FMSClient"
pushd "%vah_home%"
:START
@echo on
::Binary files
xcopy "Executables\FMSClient\bin\Release\x64\*.dll" "%working_directory%\FMSClient\Bin\Release\x64" /I /Y
xcopy "Executables\FMSClient\bin\Release\x64\*.exe" "%working_directory%\FMSClient\Bin\Release\x64" /I /Y
xcopy "Executables\FMSClient\bin\Release\x64\*.bat" "%working_directory%\FMSClient\Bin\Release\x64" /I /Y
xcopy "Executables\FMSClient\config\*.dat" "%working_directory%\FMSClient\Config" /I /Y
xcopy "Executables\FMSClient\doc\*.txt" "%working_directory%\FMSClient\doc" /I /Y
xcopy "Executables\Script\StartFMSClient.bat" "%working_directory%\FMSClient\Script\" /I /Y
xcopy "Executables\Script\fmsclient_install.bat" "%working_directory%\FMSClient\Script\" /I /Y
xcopy "Executables\Script\fmsclient_uninstall.bat" "%working_directory%\FMSClient\Script\" /I /Y
xcopy "Executables\Script\replace.pl" "%working_directory%\FMSClient\Script\" /I /Y
xcopy "Executables\Utils\perl\*" "%working_directory%\FMSClient\Utils\" /I /Y
xcopy "Executables\Utils\perl\*" "%working_directory%\FMSClient\Utils\" /I /Y
popd
:: SPB
:: ==================================================
echo Generating SPMove package ...

set drop_ver_log=%~n0_%drop_ver%.log
set spb_ver=%drop_ver%
echo %drop_ver%>"%drop_ver_log%"
for /f "tokens=1-3 delims=." %%i in (%drop_ver_log%) do set spb_ver=%%i-%%j-%%k
del /f /q "%drop_ver_log%"

"%utils%\SPBGen\SPBGen.exe" -i:DDS -c:VAA -n:FMSClient -o:Win-2008-64 -v:%spb_ver% -a:install -b:01 -S:"%working_directory%\FMSClient" -D:"D:\ThomsonReuters\FMSClient_tmp" -X:"Script\fmsclient_install.bat" -U:"Script\fmsclient_uninstall.bat" -O:"%working_directory%" -G:DDS
if errorlevel 1 goto ERROR

pushd "%working_directory%"

echo Compressing FMSClient package ...
set FMSClient_pkg=FMSClient_Pkg_%config%_V%drop_ver%.zip
if exist "%FMSClient_pkg%" del /f /q "%FMSClient_pkg%"
xcopy  /y "%vah_home%\Executables\Script\fmsclient_install.bat" .
xcopy  /y "%vah_home%\Executables\Script\fmsclient_uninstall.bat" .

"%utils%\zip.exe" -r "%FMSClient_pkg%" "FMSClient\*" "fmsclient_install.bat" "fmsclient_uninstall.bat"
del /f /q "fmsclient_install.bat"
del /f /q "fmsclient_uninstall.bat"
if errorlevel 1 goto ERROR

popd & goto END
:ERROR
echo ERROR!
endlocal & exit /b 1

:END
echo SUCCEED!
endlocal & exit /b 0

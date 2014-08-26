@echo off

set drop_ver=0.4.0
if not "%~1"=="" set drop_ver=%~1

:: due to doxygen configuration file specified WORKSPACE environment variable
:: it has to set when able to run without Jenkins, besides, input tag is also
:: depended on WORKSPACE, here need set WORKSPACE to vah trunk
set workspace >nul 2>nul
if errorlevel 1 set WORKSPACE=%cd%\..\..\..

:: due to hard code output directory in doxygen configuration file
:: here does not accept command-line parameter
set doxygen_dir=%WORKSPACE%\Package\doxygen

:START
set doxygen_home=%WORKSPACE%\SourceCode\Executables\Doxygen
set utils=%cd%\..\Utils

:: prerequisites doxygen
:: ==================================================
"%doxygen_home%\doxygen.exe" -h >nul 2>nul
if errorlevel 2 echo Doxygen program NOT found & goto ERROR

if exist "%doxygen_dir%" rd /s /q "%doxygen_dir%"
mkdir "%doxygen_dir%"


:: html documentation
:: ==================================================
echo Generating html documentation ...
if exist "%doxygen_home%\TRLogo.png" copy /Y "%doxygen_home%\TRLogo.png" "%doxygen_dir%"
if errorlevel 1 goto ERROR

"%doxygen_home%\doxygen.exe" "..\Doxygen\Doxyfile"
if errorlevel 1 goto ERROR


:: chm
:: ==================================================
set hhc_dir=%ProgramFiles%\HTML Help Workshop
if exist "%systemroot%\syswow64" set hhc_dir=%ProgramFiles(x86)%\HTML Help Workshop
echo Generating chm documentation ...
"%hhc_dir%\hhc.exe" "%doxygen_dir%\Manual\index.hhp
if errorlevel 2 goto ERROR


:: delete TRLogo.png
if exist "%doxygen_dir%\TRLogo.png"  del /f /q  "%doxygen_dir%\TRLogo.png"
if errorlevel 1 goto ERROR


:: compress
:: ==================================================
pushd "%doxygen_dir%"
echo Compressing VAH doxygen documentation ...
set vah_doxygen=VAH_Doxygen_V%drop_ver%.zip
if exist "..\%vah_doxygen%" del /f /q "..\%vah_doxygen%"
"%utils%\zip.exe" -r "..\%vah_doxygen%" *
if errorlevel 1 goto ERROR

popd & goto END


:ERROR
:: it's not mandatory now, not block building even failure
echo ERROR!   & exit /b 0

:END
echo SUCCEED! & exit /b 0

@echo off
setlocal

path c:\python25;%path%

set cppcheck_dir=%cd%\..\..\..\Package\cppcheck
set cppcheck_xml=report.xml
set cppcheck_title=VAH
set drop_ver=0.4.0

if not "%~1"=="" set cppcheck_dir=%~1
if not "%~2"=="" set drop_ver=%~2
if not "%~3"=="" set cppcheck_xml=%~3
if not "%~4"=="" set cppcheck_title=%~4

:START
set vah_home=%cd%\..\..
set cppcheck_home=%cd%\..\Cppcheck\1.50
set utils=%cd%\..\Utils
set gen_html=1

:: prerequisites python and cppcheck
:: ==================================================
python -h >nul 2>nul
if errorlevel 1 set gen_html=0
"%cppcheck_home%\cppcheck.exe" --version 2>nul
if errorlevel 1 echo Cppcheck program NOT found & goto ERROR

if exist "%cppcheck_dir%" rd /s /q "%cppcheck_dir%"
mkdir "%cppcheck_dir%"


pushd "%vah_home%"

:: code static analysis
:: ==================================================
echo Making code static analysis ...
set inc_list=-I "%cd%\Includes" -I "%cd%\Interfaces"
set check_list="%cd%\Component"
set disable_warn= 
set suppress=%cd%\suppressions.txt

:: create an empty file as suppressions to avoid no one generated when
:: not specified disable warning list
cd.>"%suppress%"
for %%i in (%disable_warn%) do echo %%~i>>"%suppress%"

"%cppcheck_home%\cppcheck.exe" --enable=all --xml %inc_list% --suppressions-list="%suppress%" %check_list% 2>"%cppcheck_dir%\%cppcheck_xml%"
if errorlevel 1 goto ERROR
del /f /q "%suppress%"


:: html report
:: ==================================================
if "%gen_html%"=="1" (
    echo Generating html report ...
    python "%cppcheck_home%\cppcheck-htmlreport.py" --title="%cppcheck_title%" --file="%cppcheck_dir%\%cppcheck_xml%" --report-dir="%cppcheck_dir%\html"
    if errorlevel 1 goto ERROR
)

popd


:: compress
:: ==================================================
pushd "%cppcheck_dir%"
echo Compressing VAH cppcheck report ...
set vah_cppcheck=VAH_Cppcheck_V%drop_ver%.zip
if exist "..\%vah_cppcheck%" del /f /q "..\%vah_cppcheck%"
"%utils%\zip.exe" -r "..\%vah_cppcheck%" *
if errorlevel 1 goto ERROR

popd & goto END


:ERROR
echo ERROR!
:: it's not mandatory now, not block building even failure
endlocal & exit /b 0

:END
echo SUCCEED!
endlocal & exit /b 0

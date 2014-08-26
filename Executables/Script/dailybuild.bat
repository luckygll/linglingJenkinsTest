@echo off

::
:: SYSTEM REQUIREMENTS
:: ==================================================
:: * WinXP SP3 or above
:: * Set Regional Options as English (United States) (MM/dd/yyyy)
:: * MS Visual Studio 2010
:: * ActivePython 2.5.4.4 (optional)
:: * Pygments 1.4 (optional)
:: * Subversion 1.6.6 or above
:: * Cppcheck 1.50 or above
:: * Quantum Framework 1.5.x
:: * Doxygen in QF
:: * CppUnit in QF
:: * SPBGen 0.7.6 or above
:: * CfgSync.exe 1.0 or above
:: * ATF 1.7 or above
::


if "%~1"==""   goto HELP
if "%~1"=="/?" goto HELP

set mode=daily
set drop=%~1

if /i "%~1"=="--nightly" (
    set mode=nightly
    set drop=%~2
)

:PRECONDITIONS
call dailybuild.pre.bat %drop%
if errorlevel 1 goto ERROR

echo.
echo mode           : %mode%
echo drop           : %drop%
echo workspace      : %WORKSPACE%
echo revision       : %revision%
echo.


:BUILD
echo.
echo #####################
echo # Building VAH load #
echo #####################
echo.
call build.bat rebuild debug   x64
if errorlevel 1 goto ERROR

call build.bat rebuild release x64
if errorlevel 1 goto ERROR

if "%mode%"=="nightly" goto DOXYGEN


:UNIT_TESTS
echo.
echo #########################
echo # Unit testing VAH load #
echo #########################
echo.
call unit.testing.bat debug   x64 "%WORKSPACE%\Package\unit_tests"
if errorlevel 1 goto ERROR


:CPPCHECK
echo.
echo ########################
echo # Cppchecking VAH load #
echo ########################
echo.
call cppcheck.bat "%WORKSPACE%\Package\cppcheck" %drop%
if errorlevel 1 goto ERROR


:DOXYGEN
echo.
echo ########################
echo # Doxygening VAH load #
echo ########################
echo.
call doxygen.bat %drop%
if errorlevel 1 goto ERROR


:PACKAGE
echo.
echo ######################
echo # Packaging VAH load #
echo ######################
echo.
call package.bat Debug   x64 "%WORKSPACE%\Package\Debug\VAH"    %drop%
if errorlevel 1 goto ERROR

call package.bat Release x64 "%WORKSPACE%\Package\Release\VAH"  %drop%
if errorlevel 1 goto ERROR


:SDK_BUILD
echo.
echo ################################
echo # Building VAH SDK Sample load #
echo ################################
echo.
call sdk.bat debug   x64
if errorlevel 1 goto ERROR

call sdk.bat release x64
if errorlevel 1 goto ERROR

call build.sdksample.bat rebuild debug   x64
if errorlevel 1 goto ERROR

call build.sdksample.bat rebuild release x64
if errorlevel 1 goto ERROR


:SDK
echo.
echo #######################
echo # Making VAH SDK load #
echo #######################
echo.
call sdk.bat debug   x64 "%WORKSPACE%\Package\SDK" %drop%
if errorlevel 1 goto ERROR

call sdk.bat release x64 "%WORKSPACE%\Package\SDK" %drop%
if errorlevel 1 goto ERROR


:TEST_UTILS
echo.
echo ##############################
echo # Making VAH Test Utils load #
echo ##############################
echo.
call testutils.bat "%WORKSPACE%\Package\testutils" %drop%
if errorlevel 1 goto ERROR

if "%mode%"=="nightly" goto POSTCONDITIONS


:AUTOMATION_TESTS
echo.
echo ############################
echo # Automation test VAH load #
echo ############################
echo.
call automation.test.bat "%WORKSPACE%\Package\automation" %drop%
if errorlevel 1 goto ERROR


:POSTCONDITIONS
call dailybuild.post.bat
if errorlevel 1 goto ERROR


goto SUCC


:HELP
echo VAH daily build.
echo. 
echo Usage:
echo    %~n0.bat [--nightly] drop
echo Options:
echo    --nightly   : nightly build, testing purposes only with the fastest build speed
echo    drop        : vah drop version, should be in x.x.x format
echo Example:
echo    %~n0.bat 0.4.0
echo    %~n0.bat --nightly 0.4.0
echo.
echo Report bugs to zilong.chen@thomsonreuters.com
goto END

:ERROR
echo DAILY BUILD ERROR!   & exit /b 1

:SUCC
echo DAILY BUILD SUCCEED! & exit /b 0

:END
pause

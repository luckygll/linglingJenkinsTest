@echo off

::
:: A wrapper to automate the build
:: It's triggered by code commit, which is going to be replaced by msbuild
::

set drop=%~1

set buildversion=01
if not "%~2"=="" set buildversion=%~2


:PRECONDITIONS
call dailybuild.pre.bat %drop%
if errorlevel 1 goto ERROR

echo.
echo drop           : %drop%
echo workspace      : %WORKSPACE%
echo revision       : %revision%
echo.


:COMPILE
echo.
echo #####################################
echo # Compiling VAH and SDK Sample load #
echo #####################################
echo.
call build.bat rebuild debug x64
if errorlevel 1 goto ERROR

call build.sdksample.bat rebuild debug x64
if errorlevel 1 goto ERROR

call build.bat rebuild release x64
if errorlevel 1 goto ERROR

call build.sdksample.bat rebuild release x64
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
call package.bat Debug   x64 "%WORKSPACE%\Package\Debug\VAH" %drop% %buildversion%
if errorlevel 1 goto ERROR

call package.bat Release x64 "%WORKSPACE%\Package\Release\VAH" %drop% %buildversion%
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


:POSTCONDITIONS
call dailybuild.post.bat
if errorlevel 1 goto ERROR


goto SUCC


:ERROR
echo BUILD ERROR!   & exit /b 1

:SUCC
echo BUILD SUCCEED! & exit /b 0

@echo off
SET URL="http://10.35.54.77/EVAAService/SendAlert"
SET CURDIR=%~dp0
SET SVCUTIL=%CURDIR%svcutil
SET WSUTIL=%CURDIR%wsutil

if not "%~1"=="" SET URL=%~1

PUSHD "%CURDIR%"

:: Clear all history files...
echo. Clear all history files...
rm -f *.wsdl *.xsd *.h *.c
if errorlevel 1 echo Clear all history files Fail... & goto ERROR


:: Generate wsdl or xsd file from WCF service
echo. Generate wsdl or xsd file from WCF service...
"%SVCUTIL%" /t:metadata %URL%
if errorlevel 1 echo Generate wsdl or xsd file from WCF service Fail... & goto ERROR


FOR /f %%i in ('dir /b *.wsdl') do set WSDL=%%i
if %WSDL%=="" echo No wsdl file found & goto ERROR
FOR /f %%i in ('dir /b *.xsd') do set XSD=%%i
if %XSD%=="" echo No xsd file found & goto ERROR
FOR /f %%i in ('dir /b *.xsd') do set XSD=%%i
if %XSD%=="" echo No xsd file found & goto ERROR


:: Generate .h and .c files from wsdl or xsd files
echo. Generate .h and .c files from wsdl or xsd files...
"%WSUTIL%" %WSDL% %XSD% schemas.microsoft.com.2003.10.Serialization.xsd
if errorlevel 1 echo Generate .h and .c files from wsdl or xsd files Fail... & goto ERROR


:: Move .h files to the AdminService
echo Move .h files to the AdminService...
move /Y *.h "%CURDIR%\..\..\..\Component\AdminAgent\"
if errorlevel 1 echo Move .h files to the AdminService Fail... & goto ERROR


:: Move .c files to the AdminService
echo Move .c files to the AdminService...
move /Y *.c "%CURDIR%\..\..\..\Component\AdminAgent\"
if errorlevel 1 echo Move .c files to the AdminService Fail... & goto ERROR


:END
echo SUCCESS!
POPD "%CURDIR%"
exit /b 0


:ERROR
echo ERROR!
POPD "%CURDIR%"
exit /b 1

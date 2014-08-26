@echo off
setlocal

set FMSCLIENT_DIR=D:\ThomsonReuters\FMSClient
set FMSCLIENT_BACKUPDIR=D:\ThomsonReuters\FMSCLIENT_BACKUP1.6.0
set SMF_DIR=D:\ThomsonReuters\SMF
set MFS_DIR=D:\ThomsonReuters\Manifest
set INSTALL_LOG=fmsclientinstall.log
set NeedReboot=0
set NeedFallback=0

:START
pushd %~dp0
echo Installing start ...
echo Installing start ... > %INSTALL_LOG%

whoami
whoami >> %INSTALL_LOG%

echo Checking prerequisites for installation. 
echo Checking prerequisites for installation. >> %INSTALL_LOG%
:: prerequisites vah, smf and setx
:: ==================================================
if not exist ".\FMSClient" (
	echo [ERROR] FMSClient package NOT exist
	echo [ERROR] FMSClient package NOT exist >> %INSTALL_LOG%
	goto ERROR
	)
sc query smf >nul 2>nul
if errorlevel 1060 (
	echo [ERROR] SMF NOT installed
	echo [ERROR] SMF NOT installed >> %INSTALL_LOG%
	goto ERROR
	)
setx /? >nul 2>nul
if errorlevel 1 (
	echo [WARNING] setx NOT exist
	echo [WARNING] setx NOT exist >> %INSTALL_LOG%
	)
	
echo Finished checking prerequisites for installation. 
echo Finished checking prerequisites for installation. >> %INSTALL_LOG%



:: stop smf service
:: ==================================================
echo Stopping SMF. 
echo Stopping SMF. >> %INSTALL_LOG%

sc query smf | findstr /i running >nul
if %errorlevel%==0 net stop smf

echo SMF is stopped. 
echo SMF is stopped. >> %INSTALL_LOG%

:: create the backup folder
echo Create Backup folder "%FMSCLIENT_BACKUPDIR%" ... 
echo Create Backup folder "%FMSCLIENT_BACKUPDIR%" ... >> %INSTALL_LOG%


if exist "%FMSCLIENT_BACKUPDIR%" (
	rd /s /q "%FMSCLIENT_BACKUPDIR%"
)
mkdir "%FMSCLIENT_BACKUPDIR%\FMSClient"

echo Backup %FMSCLIENT_DIR% to %FMSCLIENT_BACKUPDIR%\FMSClient ...
echo Backup %FMSCLIENT_DIR% to %FMSCLIENT_BACKUPDIR%\FMSClient ... >> %INSTALL_LOG%

for /d %%I in (FMSClient\*) do (
	echo. Backup %FMSCLIENT_DIR%\%%~nxI To %FMSCLIENT_BACKUPDIR%\FMSClient
	echo. Backup %FMSCLIENT_DIR%\%%~nxI To %FMSCLIENT_BACKUPDIR%\FMSClient >> %INSTALL_LOG%
	if exist "%FMSCLIENT_DIR%\%%~nxI" (
		xcopy "%FMSCLIENT_DIR%\%%~nxI" "%FMSCLIENT_BACKUPDIR%\FMSClient\%%~nxI" /y /i /r /e  >> %INSTALL_LOG%
		if errorlevel 1 (
			echo [ERROR] backup FMSClient folder failed
			echo [ERROR] backup FMSClient folder failed >> %INSTALL_LOG%
			goto ERROR
		)
	)
)

:: create folders
:: ==================================================
echo Creating folders for installation ...
echo Creating folders for installation ... >> %INSTALL_LOG%
if not exist "%FMSCLIENT_DIR%" mkdir "%FMSCLIENT_DIR%"

:: ready for installation
set NeedFallback=1
:: vah
:: ==================================================
echo Installing FMSClient ...
echo Installing FMSClient ... >> %INSTALL_LOG%

echo Copying FMSClient files ... 
echo Copying FMSClient files ... >> %INSTALL_LOG%
xcopy "FMSClient\*" "%FMSCLIENT_DIR%" /y /i /r /e  >> %INSTALL_LOG%
if errorlevel 1 (
	echo Copy FMSClient files failed ... 
	echo Copy FMSClient files failed ... >> %INSTALL_LOG%
	goto ERROR
	)

echo Finished copying FMSClient files. 	
echo Finished copying FMSClient files. >> %INSTALL_LOG%
echo Auto configuration from manifest ...
echo Auto configuration from manifest ... >> %INSTALL_LOG%
if errorlevel 1 (
	echo Auto Configuration Failed ...
	echo Auto Configuration Failed ... >> %INSTALL_LOG%
	goto ERROR
	)
	
set DST=D:\ThomsonReuters\FMSClient
set IPCONFIGFILE=%DST%\ipconfig.txt
ipconfig >%IPCONFIGFILE%
set HOSTNAMEFILE=%DST%\hostname.txt
hostname >%HOSTNAMEFILE%

SET MANIFEST=D:\ThomsonReuters\Manifest\manifest.xml
SET APPNAME=VAH

::call perl script to replace configure the ip address
%DST%\Utils\perl -w %DST%\script\replace.pl %IPCONFIGFILE% %HOSTNAMEFILE% %MANIFEST% %APPNAME% %DST%\config\fmsclient.dat

del %IPCONFIGFILE% /q 
del %HOSTNAMEFILE% /q
echo Finished auto configuration from Manifest. 
echo Finished auto configuration from Manifest. >> %INSTALL_LOG%

:: start smf service
:: ==================================================
echo Starting smf service ...
echo Starting smf service ... >> %INSTALL_LOG%
net start smf
if errorlevel 1 (
	echo Start smf failed ... 
	echo Start smf failed ... >> %INSTALL_LOG%
	goto ERROR
	)
echo Finished starting SMF service. 
echo Finished starting SMF service. >> %INSTALL_LOG%
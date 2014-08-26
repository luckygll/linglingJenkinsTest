@echo off
setlocal
set UNINSTALL_LOG=fmsclientuninstall.log
set FMSCLIENT_DIR=D:\ThomsonReuters\FMSClient
set FMSCLIENT_BACKUPDIR=D:\ThomsonReuters\FMSCLIENT_BACKUP1.6.0
set SMF_DIR=D:\ThomsonReuters\SMF
set MFS_DIR=D:\ThomsonReuters\Manifest
pushd %~dp0
echo Uninstall start > %UNINSTALL_LOG%

::Stop VAH applications before removing files
echo Stop VAH application by SMF... 
echo Stop VAH application by SMF... >> %UNINSTALL_LOG%
sc query smf | findstr /i running >nul
if %errorlevel%==0 net stop smf

echo Kill process Quantum* 
echo Kill process Quantum* >> %UNINSTALL_LOG%
taskkill /f /fi "imagename eq Quantum*"

echo Kill process WinLauncher.exe 
echo Kill process WinLauncher.exe >> %UNINSTALL_LOG%
taskkill /f /im WinLauncher.exe

echo VAH applications have been stopped. 
echo VAH applications have been stopped. >> %UNINSTALL_LOG%

::Remove VAH directory
echo Remove %FMSCLIENT_DIR% sub-folders
echo Remove %FMSCLIENT_DIR% sub-folders >> %UNINSTALL_LOG%
for /d %%I in (FMSClient\*) do (
	echo. Delete folder %FMSCLIENT_DIR%\%%~nxI
	echo. Delete folder %FMSCLIENT_DIR%\%%~nxI >> %UNINSTALL_LOG%
	rd /s /q "%FMSCLIENT_DIR%\%%~nxI"
)



::Fallback to older version.
if exist "%FMSCLIENT_BACKUPDIR%" (
	echo Start fallback FMSClient from %FMSCLIENT_BACKUPDIR%
	echo Start fallback FMSClient from %FMSCLIENT_BACKUPDIR% >> %UNINSTALL_LOG%
	
	
	::fallback FMSClient
	for /d %%I in ("%FMSCLIENT_BACKUPDIR%\FMSClient"\*) do (
		echo. Fallback %FMSCLIENT_BACKUPDIR%\FMSClient\%%~nxI To %FMSCLIENT_DIR%
		echo. Fallback %FMSCLIENT_BACKUPDIR%\FMSClient\%%~nxI To %FMSCLIENT_DIR% >> %UNINSTALL_LOG%
		mkdir "%FMSCLIENT_DIR%\%%~nxI"
		xcopy "%FMSCLIENT_BACKUPDIR%\FMSClient\%%~nxI" "%FMSCLIENT_DIR%\%%~nxI" /y /i /r /e
	)
	
	echo Fallback end.
	goto END
)

:ERROR
echo ERROR!
echo Uninstallation Failed. >> %UNINSTALL_LOG%
popd
endlocal
exit /b 1

:END
echo Uninstall complete 
echo Uninstall complete >> %UNINSTALL_LOG%
popd
endlocal
exit /b 0
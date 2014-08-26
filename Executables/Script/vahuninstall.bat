@echo off
setlocal
set UNINSTALL_LOG=vahuninstall.log
set VAH_DIR=D:\ThomsonReuters\VAH
set SCW_DIR=D:\ThomsonReuters\SCW
set SMF_DIR=D:\ThomsonReuters\SMF
set SSH_PUB_DIR=C:\Users\Administrator\.ssh
set SSH_PUB_FILE=authorized_keys
set VAH_BACKUP=D:\ThomsonReuters\VAH_BACKUP2.1.0
set FMSCLIENT_DIR=D:\ThomsonReuters\FMSClient
pushd %~dp0
echo Uninstall start > %UNINSTALL_LOG%

::Stop VAH applications before removing files
echo Stop VAH application by SMF... 
echo Stop VAH application by SMF... >> %UNINSTALL_LOG%
sc query smf | findstr /i running >nul
if %errorlevel%==0 net stop smf

echo Kill process Quantum* 
echo Kill process Quantum* >> %UNINSTALL_LOG%
tasklist /nh|find /i "Quantum"
if %errorlevel%==0 (
	taskkill /f /fi "imagename eq Quantum*"  >> %UNINSTALL_LOG%
)

echo Kill process WinLauncher.exe 
echo Kill process WinLauncher.exe >> %UNINSTALL_LOG%
tasklist /nh|find /i "WinLauncher.exe"
if %errorlevel%==0 (
	taskkill /f /im WinLauncher.exe >> %UNINSTALL_LOG%
)

echo Quantum and VAH processes have been stopped. 
echo Quantum and VAH processes have been stopped. >> %UNINSTALL_LOG%

::Remove VAH directory
echo Remove %VAH_DIR% sub-folders
echo Remove %VAH_DIR% sub-folders >> %UNINSTALL_LOG%
for /d %%I in (VAH\*) do (
	echo. Delete folder %VAH_DIR%\%%~nxI
	echo. Delete folder %VAH_DIR%\%%~nxI >> %UNINSTALL_LOG%
	rd /s /q "%VAH_DIR%\%%~nxI"
)

::Remove SCW directory
echo Remove %SCW_DIR% sub-folders
echo Remove %SCW_DIR% sub-folders >> %UNINSTALL_LOG%
for /d %%I in (SCW\*) do (
	echo. Delete folder %SCW_DIR%\%%~nxI
	echo. Delete folder %SCW_DIR%\%%~nxI >> %UNINSTALL_LOG%
	if not "%SCW_DIR%\%%~nxI"=="%SCW_DIR%\logs"  rd /s /q "%SCW_DIR%\%%~nxI"
)
::Remove FMSClient directory
echo Remove %FMSCLIENT_DIR% sub-folders
echo Remove %FMSCLIENT_DIR% sub-folders >> %UNINSTALL_LOG%
for /d %%I in (FMSClient\*) do (
	echo. Delete folder %FMSCLIENT_DIR%\%%~nxI
	echo. Delete folder %FMSCLIENT_DIR%\%%~nxI >> %UNINSTALL_LOG%
	rd /s /q "%FMSCLIENT_DIR%\%%~nxI"
)
::Fallback to older version.
if exist "%VAH_BACKUP%" (
	echo Start fallback VAH from %VAH_BACKUP%
	echo Start fallback VAH from %VAH_BACKUP% >> %UNINSTALL_LOG%
	
	rem fallback SMF Data and configuration
	echo Fallback SMF data and config
	echo Fallback SMF data and config >> %UNINSTALL_LOG%
	copy /y "%VAH_BACKUP%\SMF\*.bin" "%SMF_DIR%\Data"
	copy /y "%VAH_BACKUP%\SMF\*.xml" "%SMF_DIR%\Data"
	
	rem fallback VAH
	for /d %%I in ("%VAH_BACKUP%\VAH"\*) do (
		echo. Fallback %VAH_BACKUP%\VAH\%%~nxI To %VAH_DIR%
		echo. Fallback %VAH_BACKUP%\VAH\%%~nxI To %VAH_DIR% >> %UNINSTALL_LOG%
		mkdir "%VAH_DIR%\%%~nxI"
		xcopy "%VAH_BACKUP%\VAH\%%~nxI" "%VAH_DIR%\%%~nxI" /y /i /r /e
	)
	
	
	rem fallback SCW
	for /d %%I in ("%VAH_BACKUP%\SCW"\*) do (
		echo. Fallback %VAH_BACKUP%\SCW\%%~nxI To %SCW_DIR%
		echo. Fallback %VAH_BACKUP%\SCW\%%~nxI To %SCW_DIR% >> %UNINSTALL_LOG%
		mkdir "%SCW_DIR%\%%~nxI"
		xcopy "%VAH_BACKUP%\SCW\%%~nxI" "%SCW_DIR%\%%~nxI" /y /i /r /e
	)
	
	if not exist "%SCW_DIR%\logs" mkdir "%SCW_DIR%\logs"
		
	rem fallback FMSClient
	for /d %%I in ("%VAH_BACKUP%\FMSClient"\*) do (
		echo. Fallback %VAH_BACKUP%\FMSClient\%%~nxI To %FMSCLIENT_DIR%
		echo. Fallback %VAH_BACKUP%\FMSClient\%%~nxI To %FMSCLIENT_DIR% >> %UNINSTALL_LOG%
		mkdir "%FMSCLIENT_DIR%\%%~nxI"
		xcopy "%VAH_BACKUP%\FMSClient\%%~nxI" "%FMSCLIENT_DIR%\%%~nxI" /y /i /r /e
	)	
	rem fallback SSH
	if exist "%VAH_BACKUP%\%SSH_PUB_FILE%" (
		echo Fallback SSH key
		echo Fallback SSH key >> %UNINSTALL_LOG%
		copy /Y "%VAH_BACKUP%\%SSH_PUB_FILE%" "%SSH_PUB_DIR%"
	)
	echo Fallback ended.
	echo Fallback ended. >> %UNINSTALL_LOG%
	goto END
)

goto END
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

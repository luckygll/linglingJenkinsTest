@echo off
setlocal enabledelayedexpansion

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Set Variables                                             ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set VAH_DIR=D:\ThomsonReuters\VAH
set VAH_BACKUP=D:\ThomsonReuters\VAH_BACKUP2.1.0
set SCW_DIR=D:\ThomsonReuters\SCW
set SMF_DIR=D:\ThomsonReuters\SMF
set MFS_DIR=D:\ThomsonReuters\Manifest
set ADFIN_DIR=%VAH_DIR%\3rdParty\Adfin\Bin
set SSH_PUB_DIR=C:\Users\Administrator\.ssh
set SSH_PUB_FILE=authorized_keys
set FMSCLIENT_DIR=D:\ThomsonReuters\FMSClient
set PUB_DICTIONARY_DIR=D:\ThomsonReuters\Config
set INSTALL_LOG=vahinstall.log
set NeedReboot=0
set NeedFallback=0
set IsUpgrading=0
set DdnaNic=DDNA
set DdnbNic=DDNB
set VAHInputNic="VAH Input" 	  
set MSPatch=KB2685939
set CUR_DIR=%cd%
set ROOT_DIR=D:\ThomsonReuters
set CMPNAME=%computername%
set ENV_VAH=%CMPNAME:~0,4%
echo %CMPNAME%
echo %CUR_DIR%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Start Installing                                          ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:START
pushd %~dp0
color 02
echo :::              :::        ::::::          :::            :::
echo  :::            :::        :::  :::         :::            :::  
echo   :::          :::        :::    :::        :::            :::
echo    :::        :::        :::      :::       ::::::::::::::::::
echo     :::      :::        ::::::::::::::      ::::::::::::::::::
echo      :::    :::        ::::::::::::::::     :::            ::: 
echo       :::  :::        :::            :::    :::            :::
echo        ::::::        :::              :::   :::            :::
echo        ::::::       :::                :::  :::            :::
echo.
echo. 	

echo :::              :::        ::::::          :::            ::: > %INSTALL_LOG%
echo  :::            :::        :::  :::         :::            ::: >> %INSTALL_LOG%
echo   :::          :::        :::    :::        :::            ::: >> %INSTALL_LOG%
echo    :::        :::        :::      :::       :::::::::::::::::: >> %INSTALL_LOG%
echo     :::      :::        ::::::::::::::      :::::::::::::::::: >> %INSTALL_LOG%
echo      :::    :::        ::::::::::::::::     :::            ::: >> %INSTALL_LOG%
echo       :::  :::        :::            :::    :::            ::: >> %INSTALL_LOG%
echo        ::::::        :::              :::   :::            ::: >> %INSTALL_LOG%
echo        ::::::       :::                :::  :::            ::: >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Start Installing                                          ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Start Installing                                          :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo Installing start ...
echo Installing start ... >> %INSTALL_LOG%
whoami
whoami >> %INSTALL_LOG%


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Check Prerequisite                                        ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Check Prerequisite                                        ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Check Prerequisite                                        :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo Checking prerequisites for installation ... 
echo Checking prerequisites for installation ... >> %INSTALL_LOG%

:: Check whether activatedlabelfile exist

echo Checking whether activatedlabelfile exists ...
echo Checking whether activatedlabelfile exists ... >> %INSTALL_LOG%

if exist "%VAH_DIR%\Config\activatedlabelfile" set IsUpgrading=1
	
echo Finished Checking whether activatedlabelfile exists .
echo Finished Checking whether activatedlabelfile exists . >> %INSTALL_LOG%

:::::::::::::  end checking activatedlabelfile  :::::::::::::::

::::::::::::  begin prerequisiting vah, smf and setx  ::::::::::::

echo.
echo check Windows  Windows6.1-%MSPatch%-x64.msu 
echo. >> %INSTALL_LOG%
echo check Windows  Windows6.1-%MSPatch%-x64.msu   >> %INSTALL_LOG%

wmic qfe list full | findstr %MSPatch% >> %INSTALL_LOG%

if not exist ".\VAH" (
	echo [ERROR] VAH package NOT exist .
	echo [ERROR] VAH package NOT exist . >> %INSTALL_LOG%
	goto PRECHECK
	)

::::::::::::  begin checking manifest, disk, nic cards  ::::::::::::
	
:: check manifest/sid/fid, disk space, nic cards
:: takes 2 params, param 1 is minimal manifest version(0 means don't check version); param 2 is minimal disk space in megabytes
:: for example, this checks for 1G disk space
"VAH\Bin\preinstallcheck.exe" 0 1000 >> %INSTALL_LOG%
if %errorlevel%==1 (
	echo [ERROR] pre installation check failed .
	echo [ERROR] pre installation check failed . >> %INSTALL_LOG%
	goto PRECHECK
	)
if %errorlevel%==2 (
	echo [INFO] need reboot, set flag .
	echo [INFO] need reboot, set flag . >> %INSTALL_LOG%
	set NeedReboot=1
)

color 04
echo [Notice] If you do not get Reply from IPAddress: bytes=32 time=1ms TTL=128
echo [Notice] It shows you network connection have problems.
echo [Notice] If you do not get Reply from IPAddress: bytes=32 time=1ms TTL=128. >> %INSTALL_LOG%
echo [Notice] It shows you network connection of the nic have problems. >> %INSTALL_LOG%

::TIMEOUT /T 5 /NOBREAK > NUL

for /F "tokens=1,2* delims=:" %%i in (VAH\Bin\nic_ipaddress.txt) do (
		
        ping -n 1 %%j  | findstr /i /C:TTL	
	if errorlevel 1 ( 
	    echo [ERROR] %%i %%j is not accessiable .
	    echo [ERROR] %%i %%j is not accessiable . >>  %INSTALL_LOG%
            
        )
        ping -n 1 %%j  | findstr /i /C:TTL >> %INSTALL_LOG%
        echo %%i %%j
        echo.
        echo %%i %%j >> %INSTALL_LOG%
        echo. >> %INSTALL_LOG%
)

if exist VAH\Bin\nic_ipaddress.txt del /f /q VAH\Bin\nic_ipaddress.txt
::::::::::::  end checking manifest, disk, nic cards   ::::::::::::
	
sc query smf >nul 2>nul
if errorlevel 1060 (
	echo [ERROR] SMF NOT installed .
	echo [ERROR] SMF NOT installed . >> %INSTALL_LOG%
	goto ERROR
	)
	
setx /? >nul 2>nul
if errorlevel 1 (
	echo [WARNING] setx NOT exist .
	echo [WARNING] setx NOT exist . >> %INSTALL_LOG%
	)

color 02

:::::::::::::::: begin enabling PGM Multicast  :::::::::::::::::
::enable the PGM Multicast featute 
echo Enabling PGM Multicast feature ...
echo Enabling PGM Multicast feature ... >> %INSTALL_LOG%
if EXIST %WINDIR%\system32\dism.exe ( 
  set DISM=%WINDIR%\system32\dism.exe 
) 
if EXIST %WINDIR%\SysNative\dism.exe ( 
  set DISM=%WINDIR%\SysNative\dism.exe 
)
%DISM% /online /Get-FeatureInfo /FeatureName:MSMQ-Server | findstr Enable >> %INSTALL_LOG%
if errorlevel 1  (
	echo Did not enable MSMQ-Server .
	echo Did not enable MSMQ-Server . >>  %INSTALL_LOG%
    %DISM% /online /enable-feature /FeatureName:MSMQ-Server >> %INSTALL_LOG%
	if errorlevel 1 (
		echo [ERROR] failed to Enable MSMQ-Server .	
		echo [ERROR] failed to Enable MSMQ-Server . >> %INSTALL_LOG%
		goto ERROR
	)
    echo Enabled MSMQ-Server .	
	echo Enabled MSMQ-Server .	>> %INSTALL_LOG%
)

%DISM% /online /Get-FeatureInfo /FeatureName:MSMQ-Multicast | findstr Enable >> %INSTALL_LOG%
if errorlevel 1  (
	echo Did not enable PGM Multicast .
	echo Did not enable PGM Multicast . >> %INSTALL_LOG%
    %DISM% /online /enable-feature /FeatureName:MSMQ-Multicast >> %INSTALL_LOG%
	if errorlevel 1 (
		echo [ERROR] failed to Enable PGM Multicast .
		echo [ERROR] failed to Enable PGM Multicast . >> %INSTALL_LOG%
		goto ERROR		
		)
    echo Enabled PGM Multicast .	
	echo Enabled PGM Multicast . >> %INSTALL_LOG%
)

echo Finished enabling PGM Multicast feature .
echo Finished enabling PGM Multicast feature . >> %INSTALL_LOG%

:::::::::::::::: end enabling PGM Multicast  :::::::::::::::::

if exist VAH\Utils\nvspbind.exe ( 
	VAH\Utils\nvspbind.exe  %DdnaNic%  >> %INSTALL_LOG%
	VAH\Utils\nvspbind.exe  %DdnbNic%  >> %INSTALL_LOG%
	VAH\Utils\nvspbind.exe  %VAHInputNic% >> %INSTALL_LOG%
	VAH\Utils\nvspbind.exe  %DdnaNic% /e ms_pacer
	VAH\Utils\nvspbind.exe  %DdnbNic% /e ms_pacer
	VAH\Utils\nvspbind.exe  %VAHInputNic% /e ms_rmcast
)

echo Finished checking prerequisites for installation . 
echo Finished checking prerequisites for installation . >> %INSTALL_LOG%

::::::::::::   end prerequisiting vah, smf and setx   ::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Set System Environment                                    ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Set System Environment                                    ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Set System Environment                                    :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
:::::::::::::::  begin adding 3rdParty to PATH :::::::::::::::::

::
:: add 3rdParty to PATH system environment variable
:: ==================================================

path | findstr /i "%ADFIN_DIR%" >nul
if errorlevel 1 set NOT_FOUND=1

if defined NOT_FOUND set  CUR_PATH=%PATH%
if defined NOT_FOUND setx PATH "%CUR_PATH%;%ADFIN_DIR%" /m

:::::::::::::::::  end adding 3rdParty to PATH ::::::::::::::::::

::::::::::::::::  begin adding permanent route table  :::::::::::::::::::
:: add permanent route table
:: ==================================================
echo Starting to add persistent routes 
echo Starting to add persistent routes . >> %INSTALL_LOG%

if /i "%ENV_VAH%" == "UK1P" (
ROUTE -p ADD 10.244.67.0 MASK 255.255.255.0 10.109.32.254 METRIC 11
ROUTE -p ADD 10.245.85.0 MASK 255.255.255.0 10.109.32.254 METRIC 11
ROUTE -p ADD 172.31.244.0  MASK 255.255.255.240 10.109.32.254 METRIC 1
ROUTE -p ADD 172.26.249.208 MASK 255.255.255.240 10.109.32.254 METRIC 1
)

if /i "%ENV_VAH%" == "UK2P" (
ROUTE -p ADD 10.244.67.0 MASK 255.255.255.0 10.109.33.254 METRIC 11
ROUTE -p ADD 10.245.85.0 MASK 255.255.255.0 10.109.33.254 METRIC 11
ROUTE -p ADD 172.31.244.0  MASK 255.255.255.240 10.109.33.254 METRIC 1
ROUTE -p ADD 172.26.249.208 MASK 255.255.255.240 10.109.33.254 METRIC 1
)

echo Persistent routes are added . 
echo Persistent routes are added . >> %INSTALL_LOG%
::::::::::::::::  end adding permanent route table  :::::::::::::::::::

:::::::::::  begin checking ddn configuration file  ::::::::::::
if not exist "%PUB_DICTIONARY_DIR%\ddnLabels.xml" (
	echo [ERROR] %PUB_DICTIONARY_DIR%\ddnLabels.xml not found .
	echo [ERROR] %PUB_DICTIONARY_DIR%\ddnLabels.xml not found . >> %INSTALL_LOG%
	goto ERROR
)

if not exist "%PUB_DICTIONARY_DIR%\ddnPublishers.xml" (
	echo [ERROR] %PUB_DICTIONARY_DIR%\ddnPublishers.xml not found .
	echo [ERROR] %PUB_DICTIONARY_DIR%\ddnPublishers.xml not found . >> %INSTALL_LOG%
	goto ERROR
)

if not exist "%PUB_DICTIONARY_DIR%\ddnReqLabels.xml" (
	echo [ERROR] %PUB_DICTIONARY_DIR%\ddnReqLabels.xml not found .
	echo [ERROR] %PUB_DICTIONARY_DIR%\ddnReqLabels.xml not found . >> %INSTALL_LOG%
	goto ERROR
)

if not exist "%PUB_DICTIONARY_DIR%\ddnServers.xml" (
	echo [ERROR] %PUB_DICTIONARY_DIR%\ddnServers.xml not found .
	echo [ERROR] %PUB_DICTIONARY_DIR%\ddnServers.xml not found . >> %INSTALL_LOG%
	goto ERROR
)
:::::::::::::  end checking ddn configuration file  :::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Check Activatedlabelfile                                  ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Check Activatedlabelfile                                  ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Check Activatedlabelfile                                  :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
:::::::::::::  begin checking activatedlabelfile  :::::::::::::::

::::::::::::::::  begin stopping smf service  :::::::::::::::::::
:: stop smf service
:: ==================================================
echo Stopping SMF . 
echo Stopping SMF . >> %INSTALL_LOG%

sc query smf | findstr /i running >nul
if %errorlevel%==0 net stop smf

echo SMF is stopped . 
echo SMF is stopped . >> %INSTALL_LOG%
::::::::::::::::  end stopping smf service  :::::::::::::::::::

echo Kill process Quantum* 
echo Kill process Quantum* >> %INSTALL_LOG%

tasklist /nh|find /i "Quantum"
if %errorlevel%==0 (
	taskkill /f /fi "imagename eq Quantum*" >> %INSTALL_LOG%
)
echo Kill process WinLauncher.exe 
echo Kill process WinLauncher.exe >> %INSTALL_LOG%
tasklist /nh|find /i "WinLauncher.exe"
if %errorlevel%==0 (
	taskkill /f /im WinLauncher.exe >> %INSTALL_LOG%
)
echo Quantum and VAH processes have been stopped. 
echo Quantum and VAH processes have been stopped. >> %INSTALL_LOG%

:::::::::::::::  begin choosing backup or not  :::::::::::::::::

if %IsUpgrading%==1 (
	rem ::::::::::::::  begin backuping files  ::::::::::::::::::
	echo Create Backup folder "%VAH_BACKUP%" ... 
	echo Create Backup folder "%VAH_BACKUP%" ... >> %INSTALL_LOG%

	if exist "%VAH_BACKUP%" (
		rd /s /q "%VAH_BACKUP%"
	)

	rem backup SMF Data and configuration
	echo Backup SMF Data and configuration files ...
	echo Backup SMF Data and configuration files ... >> %INSTALL_LOG%

	mkdir "%VAH_BACKUP%\SMF"
	mkdir "%VAH_BACKUP%\SCW"
	mkdir "%VAH_BACKUP%\VAH"
    	mkdir "%VAH_BACKUP%\FMSClient"
	
	for /r "VAH\Config\SMF" %%I in (*.xml) do (
		echo. Backup %SMF_DIR%\Data\%%~nxI To %VAH_BACKUP%\SMF .
		echo. Backup %SMF_DIR%\Data\%%~nxI To %VAH_BACKUP%\SMF . >> %INSTALL_LOG%
		copy /Y "%SMF_DIR%\Data\%%~nxI" "%VAH_BACKUP%\SMF"
	)

	if exist "%SMF_DIR%\Data\vae0param.bin" (
		copy /y "%SMF_DIR%\Data\vae0param.bin" "%VAH_BACKUP%\SMF"
		if errorlevel 1 (
			echo [ERROR] Backup "%SMF_DIR%\Data\vae0param.bin" failed .
			echo [ERROR] Backup "%SMF_DIR%\Data\vae0param.bin" failed . >> %INSTALL_LOG%
			goto ERROR
		)
	)

	if exist "%SMF_DIR%\Data\vae0stats.bin" (
		copy /y "%SMF_DIR%\Data\vae0stats.bin" "%VAH_BACKUP%\SMF"
		if errorlevel 1 (
			echo [ERROR] Backup "%SMF_DIR%\Data\vae0stats.bin" failed .
			echo [ERROR] Backup "%SMF_DIR%\Data\vae0stats.bin" failed . >> %INSTALL_LOG%
			goto ERROR
		)
	)

	if exist "%SMF_DIR%\Data\SCW.bin" (
		copy /y "%SMF_DIR%\Data\SCW.bin"  "%VAH_BACKUP%\SMF"
		if errorlevel 1 (
			echo [ERROR] Backup "%SMF_DIR%\Data\SCW.bin" failed .
			echo [ERROR] Backup "%SMF_DIR%\Data\SCW.bin" failed . >> %INSTALL_LOG%
			goto ERROR
		)
	)

	echo Backup %VAH_DIR% to %VAH_BACKUP%\VAH ...
	echo Backup %VAH_DIR% to %VAH_BACKUP%\VAH ... >> %INSTALL_LOG%

	for /d %%I in (VAH\*) do (
		echo. Backup %VAH_DIR%\%%~nxI To %VAH_BACKUP%\VAH .
		echo. Backup %VAH_DIR%\%%~nxI To %VAH_BACKUP%\VAH . >> %INSTALL_LOG%
		if exist "%VAH_DIR%\%%~nxI" (
			xcopy "%VAH_DIR%\%%~nxI" "%VAH_BACKUP%\VAH\%%~nxI" /y /i /r /e  >> %INSTALL_LOG%
			if errorlevel 1 (
				echo [ERROR] backup VAH folder failed .
				echo [ERROR] backup VAH folder failed . >> %INSTALL_LOG%
				goto ERROR
			)
		)
	)
	 
	echo Backup %SCW_DIR% to %VAH_BACKUP%\SCW ...
	echo Backup %SCW_DIR% to %VAH_BACKUP%\SCW ... >> %INSTALL_LOG%

	for /d %%I in (SCW\*) do (
		echo. Backup %SCW_DIR%\%%~nxI To %VAH_BACKUP%\SCW .
		echo. Backup %SCW_DIR%\%%~nxI To %VAH_BACKUP%\SCW . >> %INSTALL_LOG%
		if exist "%SCW_DIR%\%%~nxI" (
			if   "%SCW_DIR%\%%~nxI"=="%SCW_DIR%\logs" (
				if not exist "%VAH_BACKUP%\SCW\logs" mkdir "%VAH_BACKUP%\SCW\logs"
			)
			if not "%SCW_DIR%\%%~nxI"=="%SCW_DIR%\logs" (
				xcopy "%SCW_DIR%\%%~nxI" "%VAH_BACKUP%\SCW\%%~nxI" /y /i /r /e >> %INSTALL_LOG%
				if errorlevel 1 (
					echo [ERROR] backup SCW folder failed .
					echo [ERROR] backup SCW folder failed . >> %INSTALL_LOG%
					goto ERROR
				)
			)
		)
	)
	 
	echo Backup SSH ... 
	echo Backup SSH ... >> %INSTALL_LOG%
	if exist "%SSH_PUB_DIR%\%SSH_PUB_FILE%" (
		copy /Y "%SSH_PUB_DIR%\%SSH_PUB_FILE%" "%VAH_BACKUP%"
		if errorlevel 1 (
			echo [ERROR] backup SSH pub key failed .
			echo [ERROR] backup SSH pub key failed . >> %INSTALL_LOG%
			goto ERROR
		)
	)	
	
	echo Backup FMSClient ... 
	echo Backup FMSClient ... >> %INSTALL_LOG%

	for /d %%I in (FMSClient\*) do (
		echo. Backup %FMSCLIENT_DIR%\%%~nxI To %VAH_BACKUP%\FMSClient .
		echo. Backup %FMSCLIENT_DIR%\%%~nxI To %VAH_BACKUP%\FMSClient . >> %INSTALL_LOG%
		if exist "%FMSCLIENT_DIR%\%%~nxI" (
			xcopy "%FMSCLIENT_DIR%\%%~nxI" "%VAH_BACKUP%\FMSClient\%%~nxI" /y /i /r /e >> %INSTALL_LOG%
			if errorlevel 1 (
				echo [ERROR] backup FMSClient folder failed .
				echo [ERROR] backupFMSClient folder failed  . >> %INSTALL_LOG%
				goto ERROR
			)
		)
	)
)

:::::::::::::::  end choosing backup or not  :::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Create Folders                                            ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Create Folders                                            ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Create Folders                                            :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
::::::::::::::::::: begin creating folders  ::::::::::::::::::::
:: create folders
:: ==================================================

echo Creating folders for installation ...
echo Creating folders for installation ... >> %INSTALL_LOG%
if not exist "%VAH_DIR%" mkdir "%VAH_DIR%"
if not exist "%SCW_DIR%" mkdir "%SCW_DIR%"
if not exist "%MFS_DIR%" mkdir "%MFS_DIR%"
if not exist "%ADFIN_DIR%" mkdir "%ADFIN_DIR%"
if not exist "%VAH_DIR%\3rdParty\Adfin\Config\Log" mkdir "%VAH_DIR%\3rdParty\Adfin\Config\Log"
if not exist "%VAH_DIR%\3rdParty\Adfin\Config\Original Dat Files" mkdir "%VAH_DIR%\3rdParty\Adfin\Config\Original Dat Files"
if not exist "%FMSCLIENT_DIR%" mkdir "%FMSCLIENT_DIR%"

echo Finished creating folders . 
echo Finished creating folders . >> %INSTALL_LOG%


:: create systemcrashdumps file
echo Creating SystemCrashdumps dir ...
echo Creating SystemCrashdumps dir ... >> %INSTALL_LOG%

if not exist "%VAH_DIR%\SystemCrashdumps" mkdir "%VAH_DIR%\SystemCrashdumps"

echo Finished Creating SystemCrashdumps dir .
echo Finished Creating SystemCrashdumps dir . >> %INSTALL_LOG%

:::::::::::::::::::: end creating folders  :::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Install VAH                                               ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Install VAH                                               ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Install VAH                                               :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
:::::::::::::::::::: begin copying VAH  ::::::::::::::::::::::::
:: ready for installation
set NeedFallback=1
:: vah
:: ==================================================
echo Installing VAH ...
echo Installing VAH ... >> %INSTALL_LOG%

echo Copying VAH files ... 
echo Copying VAH files ... >> %INSTALL_LOG%
xcopy "VAH\*" "%VAH_DIR%" /y /i /r /e  > vah.txt
type vah.txt >>  %INSTALL_LOG%
if errorlevel 1 (
	echo [ERROR] Copy VAH files failed ... 
	echo [ERROR] Copy VAH files failed ... >> %INSTALL_LOG%
	goto ERROR
	)
type vah.txt | findstr VAH > vah_file.txt
::pause
for /F "delims=" %%i in (vah_file.txt) do (
	set newfile="%CUR_DIR%\%%i"
	VAH\Utils\md5.exe "%CUR_DIR%\%%i"  > vah_new.txt
	VAH\Utils\md5.exe "%ROOT_DIR%\%%i"  > vah_old.txt	
	for /F "tokens=1,2* delims= " %%k in (vah_new.txt) do (
		set NEW_SIG=%%k
		set NEW_FILE=!newfile!
		for /F "tokens=1,2* delims= " %%j in (vah_old.txt) do (
			set OLD_SIG=%%j
			set OLD_FILE=%%k
			if !NEW_SIG!==!OLD_SIG! ( 
				echo !NEW_SIG!           !NEW_FILE!    
				echo !OLD_SIG!           "!OLD_FILE!"      
				echo !NEW_SIG!  equals   !OLD_SIG! .   
				echo !NEW_SIG!           !NEW_FILE!       >> %INSTALL_LOG%
				echo !OLD_SIG!           "!OLD_FILE!"       >> %INSTALL_LOG%
				echo !NEW_SIG!  equals   !OLD_SIG! .   >> %INSTALL_LOG%
			)
			
			if not !NEW_SIG!==!OLD_SIG! (
				echo !NEW_SIG!           !NEW_FILE!    
				echo !OLD_SIG!           "!OLD_FILE!"      
				echo !NEW_SIG! not equal !OLD_SIG! .   
				echo !NEW_SIG!           !NEW_FILE!       >> %INSTALL_LOG%
				echo !OLD_SIG!           "!OLD_FILE!"       >> %INSTALL_LOG%
				echo !NEW_SIG! not equal !OLD_SIG! .   >> %INSTALL_LOG%
				echo !NEW_FILE! and "!OLD_FILE!" are not same .
				echo !NEW_FILE! and "!OLD_FILE!" are not same .  >> %INSTALL_LOG%
				goto ERROR
			)
		)
	)
)


if exist "%CUR_DIR%\vah_new.txt"  del /f /q "%CUR_DIR%\vah_new.txt" 
if exist "%CUR_DIR%\vah_old.txt"  del /f /q "%CUR_DIR%\vah_old.txt" 
if exist "%CUR_DIR%\vah_file.txt"  del /f /q "%CUR_DIR%\vah_file.txt" 
if exist "%CUR_DIR%\vah.txt"  del /f /q "%CUR_DIR%\vah.txt" 

echo Finished copying VAH files . 	
echo Finished copying VAH files . >> %INSTALL_LOG%

:::::::::::::::::::::: end copying VAH  ::::::::::::::::::::::::

:::::::::::::::::::::: begin copying SCW  ::::::::::::::::::::::
:: scw
:: ==================================================
echo Copying SCW files ...
echo Copying SCW files ... >> %INSTALL_LOG%
xcopy "SCW\*" "%SCW_DIR%" /y /i /r /e  > scw.txt
type scw.txt >>  %INSTALL_LOG%
if errorlevel 1 (
	echo Copy SCW files failed ...
	echo Copy SCW files failed ... >> %INSTALL_LOG%
	goto ERROR
	)
type scw.txt | findstr SCW > scw_file.txt
for /F "delims=" %%i in (scw_file.txt) do (
	VAH\Utils\md5.exe "%CUR_DIR%\%%i"  > scw_new.txt
	VAH\Utils\md5.exe "%ROOT_DIR%\%%i"  > scw_old.txt
	set newfile="%CUR_DIR%\%%i"	
	for /F "tokens=1,2* delims= " %%k in (scw_new.txt) do (
		set NEW_SIG=%%k
		set NEW_FILE=!newfile!
		for /F "tokens=1,2* delims= " %%j in (scw_old.txt) do (
			set OLD_SIG=%%j
			set OLD_FILE=%%k
			if !NEW_SIG!==!OLD_SIG! ( 
				echo !NEW_SIG!           !NEW_FILE!     
				echo !OLD_SIG!           "!OLD_FILE!"      
				echo !NEW_SIG!  equals   !OLD_SIG! .   
				echo !NEW_SIG!           "!NEW_FILE!"       >> %INSTALL_LOG%
				echo !OLD_SIG!           "!OLD_FILE!"       >> %INSTALL_LOG%
				echo !NEW_SIG!  equals   !OLD_SIG! .   >> %INSTALL_LOG%
			)
			
			if not !NEW_SIG!==!OLD_SIG! (
				echo !NEW_SIG!           !NEW_FILE!    
				echo !OLD_SIG!           "!OLD_FILE!"      
				echo !NEW_SIG! not equal !OLD_SIG! .   
				echo !NEW_SIG!           !NEW_FILE!       >> %INSTALL_LOG%
				echo !OLD_SIG!           "!OLD_FILE!"       >> %INSTALL_LOG%
				echo !NEW_SIG! not equal !OLD_SIG! .   >> %INSTALL_LOG%
				echo !NEW_FILE! and "!OLD_FILE!" are not same .
				echo !NEW_FILE! and "!OLD_FILE!" are not same .  >> %INSTALL_LOG%
				goto ERROR
			)
		)
	)
)

if exist "%CUR_DIR%\scw_new.txt" del /f /q "%CUR_DIR%\scw_new.txt"
if exist "%CUR_DIR%\scw_old.txt" del /f /q "%CUR_DIR%\scw_old.txt" 
if exist "%CUR_DIR%\scw_file.txt" del /f /q "%CUR_DIR%\scw_file.txt"
if exist "%CUR_DIR%\scw.txt" del /f /q "%CUR_DIR%\scw.txt" 

echo Finished copying SCW files . 
echo Finished copying SCW files . >> %INSTALL_LOG%

::::::::::::::::::::: end copying SCW  :::::::::::::::::::::::::

::::::::::::::::::: begin copying FMSClient  :::::::::::::::::::
:: FMSClient
:: ==================================================
echo Copying FMSClient files ...
echo Copying FMSClient files ... >> %INSTALL_LOG%
xcopy "FMSClient\*" "%FMSCLIENT_DIR%" /y /i /r /e  > fmsclient.txt
type fmsclient.txt >>  %INSTALL_LOG%
if errorlevel 1 (
	echo Copy FMSClient files failed .
	echo Copy FMSClient files failed . >> %INSTALL_LOG%
	goto ERROR
	)
type fmsclient.txt | findstr FMSClient > fmsclient_file.txt
for /F "delims=" %%i in (fmsclient_file.txt) do (
	VAH\Utils\md5.exe "%CUR_DIR%\%%i"  > fmsclient_new.txt
	VAH\Utils\md5.exe "%ROOT_DIR%\%%i"  > fmsclient_old.txt
	set newfile="%CUR_DIR%\%%i"	
	for /F "tokens=1,2* delims= " %%k in (fmsclient_new.txt) do (
		set NEW_SIG=%%k
		set NEW_FILE=!newfile!
		for /F "tokens=1,2* delims= " %%j in (fmsclient_old.txt) do (
			set OLD_SIG=%%j
			set OLD_FILE=%%k
			if !NEW_SIG!==!OLD_SIG! ( 
				echo !NEW_SIG!           !NEW_FILE!     
				echo !OLD_SIG!           "!OLD_FILE!"      
				echo !NEW_SIG!  equals   !OLD_SIG! .   
				echo !NEW_SIG!           !NEW_FILE!       >> %INSTALL_LOG%
				echo !OLD_SIG!           "!OLD_FILE!"       >> %INSTALL_LOG%
				echo !NEW_SIG!  equals   !OLD_SIG! .   >> %INSTALL_LOG%
			)
			
			if not !NEW_SIG!==!OLD_SIG! (
				echo !NEW_SIG!           !NEW_FILE!    
				echo !OLD_SIG!           "!OLD_FILE!"      
				echo !NEW_SIG! not equal !OLD_SIG! .   
				echo !NEW_SIG!           !NEW_FILE!       >> %INSTALL_LOG%
				echo !OLD_SIG!           "!OLD_FILE!"       >> %INSTALL_LOG%
				echo !NEW_SIG! not equal !OLD_SIG! .   >> %INSTALL_LOG%
				echo !NEW_FILE! and "!OLD_FILE!" are not same .
				echo !NEW_FILE! and "!OLD_FILE!" are not same .  >> %INSTALL_LOG%
				goto ERROR
			)
		)
	)
)

if exist "%CUR_DIR%\fmsclient_new.txt" del /f /q "%CUR_DIR%\fmsclient_new.txt" 
if exist "%CUR_DIR%\fmsclient_old.txt" del /f /q "%CUR_DIR%\fmsclient_old.txt" 
if exist "%CUR_DIR%\fmsclient_file.txt" del /f /q "%CUR_DIR%\fmsclient_file.txt" 
if exist "%CUR_DIR%\fmsclient.txt" del /f /q "%CUR_DIR%\fmsclient.txt"


xcopy "%PUB_DICTIONARY_DIR%\TRWF2.DAT" "%FMSCLIENT_DIR%\Config\" /y /i /r /e >> %INSTALL_LOG%
if errorlevel 1 (
	echo Copy FMSClient trwf2.dat files failed .
	echo Copy FMSClient trwf2.dat files failed . >> %INSTALL_LOG%
	goto ERROR
	)
echo Finished copying FMSClient files . 
echo Finished copying FMSClient files . >> %INSTALL_LOG%

:::::::::::::::::::: end copying FMSClient  ::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Configuring and Generating configuration file             ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Configuring and Generating configuration file             ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Configuring and Generating configuration file             :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
::::::::::::::::: begin auto configuration  ::::::::::::::::::::
:: manifest
:: ==================================================
:: manifest is a common file among elekron system, no need install from vah any more
:: echo Installing manifest ...
:: copy /y "VAH\Config\Manifest.xml" "%MFS_DIR%"
:: if errorlevel 1 goto ERROR

echo Auto configuration from manifest ...
echo Auto configuration from manifest ... >> %INSTALL_LOG%
"VAH\Bin\cfgsync.exe"  >> %INSTALL_LOG%
if errorlevel 1 (
	echo Auto Configuration Failed ...
	echo Auto Configuration Failed ... >> %INSTALL_LOG%
	goto ERROR
	)

echo Finished auto configuration from Manifest .  
echo Finished auto configuration from Manifest . >> %INSTALL_LOG%

::::::::::::::::::: end auto configuration  ::::::::::::::::::::

::::::::::::::::::: begin configuring SMF   ::::::::::::::::::::
:: smf
:: ==================================================
echo Configuring SMF ...
echo Configuring SMF ... >> %INSTALL_LOG%
path %SMF_DIR%\bin;%path%

echo Copying SMF configuration files ... 
echo Copying SMF configuration files ... >> %INSTALL_LOG%
xcopy "%VAH_DIR%\Config\SMF\*" "%SMF_DIR%\Data" /y /i /r /e >> %INSTALL_LOG%
if errorlevel 1 (
	echo Copy SMF configuration files failed . 
	echo Copy SMF configuration files failed . >> %INSTALL_LOG%
	goto ERROR
	)

echo Finished copying SMF configuration files . 
echo Finished copying SMF configuration files . >> %INSTALL_LOG%

echo Finished configuring SMF . 
echo Finished configuring SMF . >> %INSTALL_LOG%
:::::::::::::::::::: end configuring SMF   :::::::::::::::::::::

:::::::::::::: begin configuring FMSConnector   ::::::::::::::::
::Support FMSConnector configuration according to manifest
rem set DST=%VAH_DIR%
rem set IPCONFIGFILE=%DST%\ipconfig.txt
rem ipconfig >%IPCONFIGFILE%
rem set HOSTNAMEFILE=%DST%\hostname.txt
rem hostname >%HOSTNAMEFILE%

rem SET MANIFEST=%MFS_DIR%\manifest.xml
rem SET APPNAME=VAH

::call perl script to replace configure the ip address
rem echo config FMSConnectorConfig.xml according manifest files ... 
rem echo config FMSConnectorConfig.xml according manifest files ... >> %INSTALL_LOG%
rem %DST%\Utils\perl -w %DST%\script\replace.pl %IPCONFIGFILE% %HOSTNAMEFILE% %MANIFEST% %APPNAME% %DST%\config\FMSConnectorConfig.xml
rem echo config fmsclient.dat according manifest files ... 
rem echo config fmsclient.dat according manifest files ... >> %INSTALL_LOG%
rem %DST%\Utils\perl -w %DST%\script\replace.pl %IPCONFIGFILE% %HOSTNAMEFILE% %MANIFEST% %APPNAME% %FMSCLIENT_DIR%\config\fmsclient.dat

rem echo config fmsclient startup setting in smf configuration according manifest files ... 
rem echo config fmsclient startup setting in smf configuration according manifest files ... >> %INSTALL_LOG%
rem %DST%\Utils\perl -w %DST%\script\replace.pl %IPCONFIGFILE% %HOSTNAMEFILE% %MANIFEST% %APPNAME% %SMF_DIR%\Data\smf-configuration.xml
rem del %IPCONFIGFILE% /q 
rem del %HOSTNAMEFILE% /q
::End configuration applied manifest
::::::::::::::: end configuring FMSConnector   :::::::::::::::::

:::::::::::::: begin generating SMF bin files   ::::::::::::::::
echo Generation SMF bin files . 
echo Generation SMF bin files . >> %INSTALL_LOG%
pushd "%VAH_DIR%\Config"

PsdXml2Bin.exe "vae0param.xml"
if errorlevel 1 (
	goto ERROR
	)

PsdXml2Bin.exe "vae0stats.xml"
if errorlevel 1 (
	goto ERROR
	)

PsdXml2Bin.exe "SCW.xml"
if errorlevel 1 (
	goto ERROR
	)

move /y "vae0param.bin" "%SMF_DIR%\Data"
if errorlevel 1 (
	goto ERROR
	)

move /y "vae0stats.bin" "%SMF_DIR%\Data"
if errorlevel 1 (
	goto ERROR
	)

move /y "SCW.bin"       "%SMF_DIR%\Data"
if errorlevel 1 (
	goto ERROR
	)

popd

echo Finished generation bin files . 
echo Finished generation bin files . >> %INSTALL_LOG%

:::::::::::::: end generating SMF bin files   ::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Install SSH Public Key                                    ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Install SSH Public Key                                    ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Install SSH Public Key                                    :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
:: ssh public key
:: ==================================================
echo Installing ssh public key . 
echo Installing ssh public key . >> %INSTALL_LOG%

if not exist "%SSH_PUB_DIR%" mkdir "%SSH_PUB_DIR%"
if errorlevel 1 (
	echo Making directory for public key failed ... 
	echo Making directory for public key failed ... >> %INSTALL_LOG%
	goto ERROR
	)
type "%VAH_DIR%\Config\%SSH_PUB_FILE%" >> "%SSH_PUB_DIR%\%SSH_PUB_FILE%"
if errorlevel 1 (
	echo Creating public key file failed ... 
	echo Creating public key file failed ... >> %INSTALL_LOG%
	goto ERROR
	)
	
echo Finished installing ssh public key . 	
echo Finished installing ssh public key . >> %INSTALL_LOG%



if %IsUpgrading%==1 (

	echo Copying the latest Holiday.xml from %VAH_BACKUP%\VAH\Config to %VAH_DIR%\Config ...
	echo Copying the latest Holiday.xml from %VAH_BACKUP%\VAH\Config to %VAH_DIR%\Config ... >>  %INSTALL_LOG%
	if exist "%VAH_BACKUP%\VAH\Config\Holiday.xml" xcopy /y "%VAH_BACKUP%\VAH\Config\Holiday.xml"  "%VAH_DIR%\Config"
	if errorlevel 1 (
		echo Copying Holidy.xml failed ...
		echo Copying Holidy.xml failed ... >> %INSTALL_LOG%
		goto ERROR
	)
	echo Finished Copying Holiday.xml .
	echo Finished Copying Holiday.xml . >> %INSTALL_LOG%
	
	echo Removing activatedlabelfile ...
    echo Removing activatedlabelfile ... >> %INSTALL_LOG%
	rd "%VAH_DIR%\Config\activatedlabelfile" /s /q
	echo Finished removing activatedlabelfile .
    echo Finished removing activatedlabelfile . >> %INSTALL_LOG%
)
if %NeedReboot%==1 (
	echo Install success, reboot in 15 seconds. Please type "shutdown /a" to abort .
	echo Install success, reboot in 15 seconds. Please type "shutdown /a" to abort . >> %INSTALL_LOG%
	shutdown -t 15 -r -f
	goto END
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Start SMF                                                 ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Start SMF                                                 ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Start SMF                                                 :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
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
echo Finished starting SMF service . 
echo Finished starting SMF service . >> %INSTALL_LOG%

:: post check 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Post Check                                                ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Post Check                                                ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Post Check                                                :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%

echo.
echo Postcheck Windows  Windows6.1-%MSPatch%-x64.msu 
echo. >> %INSTALL_LOG%
echo Postcheck Windows  Windows6.1-%MSPatch%-x64.msu   >> %INSTALL_LOG%
wmic qfe list full | findstr %MSPatch%
wmic qfe list full | findstr %MSPatch% >> %INSTALL_LOG%

echo.
echo Postcheck running processes
echo. >> %INSTALL_LOG%
echo. 
echo Postcheck running processes  >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%

tasklist | findstr smfd.exe 
tasklist | findstr smfd.exe >> %INSTALL_LOG%
if errorlevel 1 (
	echo [ERROR] smfd.exe is not running .
	echo [ERROR] smfd.exe is not running . >> %INSTALL_LOG%
	)
	
tasklist | findstr smf.exe 
tasklist | findstr smf.exe >> %INSTALL_LOG%
if errorlevel 1 (
	echo [ERROR] smf.exe is not running .
	echo [ERROR] smf.exe is not running . >> %INSTALL_LOG%
	) 
	
tasklist | findstr SCWAdapter.exe  
tasklist | findstr SCWAdapter.exe  >> %INSTALL_LOG%
if errorlevel 1 (
	echo [ERROR] SCWAdapter.exe is not running .
	echo [ERROR] SCWAdapter.exe is not running . >> %INSTALL_LOG%
	) 
	
tasklist | findstr SCWatchdog.exe  
tasklist | findstr SCWatchdog.exe >> %INSTALL_LOG%
if errorlevel 1 (
	echo [ERROR] SCWatchdog.exe is not running .
	echo [ERROR] SCWatchdog.exe is not running . >> %INSTALL_LOG%
	)
	
tasklist | findstr WinLauncher.exe  
tasklist | findstr WinLauncher.exe >> %INSTALL_LOG%
if errorlevel 1 (
	echo [ERROR] WinLauncher.exe is not running .
	echo [ERROR] WinLauncher.exe is not running . >> %INSTALL_LOG%
	)


echo.
echo Postcheck SMF Version 
echo. >> %INSTALL_LOG%
echo Postcheck SMF Version    >> %INSTALL_LOG%

if exist %SMF_DIR%\bin\HostManager.exe (
	%SMF_DIR%\bin\HostManager.exe -query-pkg 
	%SMF_DIR%\bin\HostManager.exe -query-pkg  	>> %INSTALL_LOG%
	)
	
echo.
echo Postcheck VAH Version 
echo. >> %INSTALL_LOG%
echo Postcheck VAH Version    >> %INSTALL_LOG%

if exist %SMF_DIR%\bin\HostManager.exe (
	%SMF_DIR%\bin\HostManager.exe -readparams /vae0_vaemanager/Application_Version
	%SMF_DIR%\bin\HostManager.exe -readparams /vae0_vaemanager/Application_Version	>> %INSTALL_LOG%
    )

echo.
echo Postcheck SCW Version 
echo. >> %INSTALL_LOG%
echo Postcheck SCW Version    >> %INSTALL_LOG%
if exist %SCW_DIR%\bin\SCWCli.exe (
	%SCW_DIR%\bin\SCWCli.exe > temp.txt 2>&1
	findstr SCWCli temp.txt
	findstr SCWCli temp.txt >> %INSTALL_LOG% 
)

echo.
echo Postcheck IDN Marketfeed enumerated tables version
echo. >> %INSTALL_LOG%
echo. 
echo Postcheck IDN Marketfeed enumerated tables version >> %INSTALL_LOG%
echo. >> %INSTALL_LOG% 

findstr Version  %PUB_DICTIONARY_DIR%\APPENDIXB.DAT > temp.txt
findstr RT_Version   temp.txt > tem.txt
for /F "tokens=1,2,3* delims= " %%i in (tem.txt) do ( 
    echo %%j is %%k 
    echo %%j is %%k  >> %INSTALL_LOG%
    )

findstr DT_Version %PUB_DICTIONARY_DIR%\APPENDIXB.DAT  > temp.txt
findstr DT_Version   temp.txt > tem.txt
for /F "tokens=1,2,3* delims= " %%i in (tem.txt) do ( 
    echo %%j is %%k 
    echo %%j is %%k  >> %INSTALL_LOG%
    )

echo.
echo Postcheck SID_DATABASE_INFO File Version
echo. >> %INSTALL_LOG%
echo Postcheck SID_DATABASE_INFO File Version >> %INSTALL_LOG%

findstr SID_DATABASE_INFO %PUB_DICTIONARY_DIR%\SID2.DAT
findstr SID_DATABASE_INFO %PUB_DICTIONARY_DIR%\SID2.DAT >> %INSTALL_LOG%

echo.
echo Postcheck trwf2 File Version
echo. >> %INSTALL_LOG%
echo Postcheck trwf2 File Version >> %INSTALL_LOG%

findstr Version  %PUB_DICTIONARY_DIR%\TRWF2.DAT > temp.txt
findstr tag  temp.txt > tem.txt
for /F "tokens=1,2,3* delims= " %%i in (tem.txt) do ( 
    echo TRWF2 File %%j is %%k 
    echo TRWF2 File %%j is %%k  >> %INSTALL_LOG%
    )

echo.
echo Postcheck ddnLabels File Version
echo. >> %INSTALL_LOG% 
echo Postcheck ddnLabels File Version >> %INSTALL_LOG%

findstr TEXT %PUB_DICTIONARY_DIR%\ddnLabels.xml > temp.txt
for /F "tokens=1,2* delims==>" %%i in (temp.txt) do ( 
	echo ddnLabels File version is %%j
	echo ddnLabels File version is %%j >> %INSTALL_LOG%
	)
	
echo.
echo Postcheck ddnPublishers File Version
echo. >> %INSTALL_LOG%
echo Postcheck ddnPublishers File Version >> %INSTALL_LOG%

findstr TEXT %PUB_DICTIONARY_DIR%\ddnPublishers.xml > temp.txt
for /F "tokens=1,2* delims==>" %%i in (temp.txt) do ( 
	echo ddnPublishers File version is %%j
	echo ddnPublishers File version is %%j >> %INSTALL_LOG%
	)

echo.
echo Postcheck ddnReqLabels File Version
echo. >> %INSTALL_LOG%
echo Postcheck ddnReqLabels File Version  >> %INSTALL_LOG%

findstr TEXT %PUB_DICTIONARY_DIR%\ddnReqLabels.xml > temp.txt
for /F "tokens=1,2* delims==>" %%i in (temp.txt) do ( 
	echo ddnReqLabels File version is %%j
	echo ddnReqLabels File version is %%j >> %INSTALL_LOG%
	)

echo.
echo Postcheck ddnServers File Version
echo. >> %INSTALL_LOG%
echo Postcheck ddnServers File Version >> %INSTALL_LOG%


findstr TEXT %PUB_DICTIONARY_DIR%\ddnServers.xml > temp.txt
for /F "tokens=1,2,3* delims==>" %%i in (temp.txt) do ( 
	echo ddnServers File version is %%j
	echo ddnServers File version is %%j >> %INSTALL_LOG%
	)

if exist "%CUR_DIR%\temp.txt" del /f /q  "%CUR_DIR%\temp.txt"	
if exist "%CUR_DIR%\tem.txt" del /f /q  "%CUR_DIR%\tem.txt"

::Clear the smf position for PCN version if is defined
:: ==================================================
echo.
echo. >> %INSTALL_LOG%
hostmanager  -readparams /vae0/pcnversion |  findstr /i failed >nul
if %errorlevel% EQU 1 ( hostmanager -writeparams /vae0/pcnversion=NoPCN as String
echo Finished clearing the PCN version . >> %INSTALL_LOG%
)

goto END

:ERROR

echo ERROR!

if %IsUpgrading%==1 (
	echo.
	echo.
	echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	echo ::  Fallback                                                  ::
	echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	echo. >> %INSTALL_LOG%
	echo. >> %INSTALL_LOG%
	echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
	echo ::  Fallback                                                  :: >> %INSTALL_LOG%
	echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
	echo Installation Failed . >> %INSTALL_LOG%
	if %NeedFallback%==1 (
		echo Start fallback ...
		echo Start fallback ... >> %INSTALL_LOG%
	
		echo Stop smf service ... 
		echo Stop smf service ... >> %INSTALL_LOG%
		net stop smf
	
		rem fallback SMF Data and configuration
		echo Fallback SMF data and config .
		echo Fallback SMF data and config . >> %INSTALL_LOG%
		copy /y "%VAH_BACKUP%\SMF\*.bin" "%SMF_DIR%\Data"
		copy /y "%VAH_BACKUP%\SMF\*.xml" "%SMF_DIR%\Data"

		rem fallback VAH
		for /d %%I in ("%VAH_BACKUP%\VAH"\*) do (
			echo. Fallback %VAH_BACKUP%\VAH\%%~nxI To %VAH_DIR% .
			echo. Fallback %VAH_BACKUP%\VAH\%%~nxI To %VAH_DIR% . >> %INSTALL_LOG%
			rd /s /q "%VAH_DIR%\%%~nxI"
			mkdir "%VAH_DIR%\%%~nxI"
			xcopy "%VAH_BACKUP%\VAH\%%~nxI" "%VAH_DIR%\%%~nxI" /y /i /r /e >> %INSTALL_LOG%
		)

		rem fallback SCW
		for /d %%I in ("%VAH_BACKUP%\SCW"\*) do (
			echo. Fallback %VAH_BACKUP%\SCW\%%~nxI To %SCW_DIR% .
			echo. Fallback %VAH_BACKUP%\SCW\%%~nxI To %SCW_DIR% . >> %INSTALL_LOG%
			if not "%SCW_DIR%\%%~nxI"=="%SCW_DIR%\logs" rd /s /q "%SCW_DIR%\%%~nxI"
			mkdir "%SCW_DIR%\%%~nxI"
			xcopy "%VAH_BACKUP%\SCW\%%~nxI" "%SCW_DIR%\%%~nxI" /y /i /r /e >> %INSTALL_LOG%
		)
	
		if not exist "%SCW_DIR%\logs" mkdir "%SCW_DIR%\logs"
		
		rem fallback SSH
		if exist "%VAH_BACKUP%\%SSH_PUB_FILE%" (
			echo Fallback SSH key .
			echo Fallback SSH key . >> %INSTALL_LOG%
			copy /Y "%VAH_BACKUP%\%SSH_PUB_FILE%" "%SSH_PUB_DIR%" >> %INSTALL_LOG%
		)
		
		rem fallback FMSClient
	    for /d %%I in ("%VAH_BACKUP%\FMSClient"\*) do (
		echo. Fallback %VAH_BACKUP%\FMSClient\%%~nxI To %FMSCLIENT_DIR% .
		echo. Fallback %VAH_BACKUP%\FMSClient\%%~nxI To %FMSCLIENT_DIR% . >> %INSTALL_LOG%
		rd /s /q "%FMSCLIENT_DIR%\%%~nxI"
		mkdir "%FMSCLIENT_DIR%\%%~nxI"
		xcopy "%VAH_BACKUP%\FMSClient\%%~nxI" "%FMSCLIENT_DIR%\%%~nxI" /y /i /r /e >> %INSTALL_LOG%
	   )
		echo Fallback ended .
		echo Fallback ended . >> %INSTALL_LOG%
	)

	if exist "%CUR_DIR%\vah_new.txt"  del /f /q "%CUR_DIR%\vah_new.txt" 
	if exist "%CUR_DIR%\vah_old.txt"  del /f /q "%CUR_DIR%\vah_old.txt"
	if exist "%CUR_DIR%\vah_file.txt"  del /f /q "%CUR_DIR%\vah_file.txt" 
	if exist "%CUR_DIR%\vah.txt"  del /f /q "%CUR_DIR%\vah.txt" 

	if exist "%CUR_DIR%\scw_new.txt" del /f /q "%CUR_DIR%\scw_new.txt"
	if exist "%CUR_DIR%\scw_old.txt" del /f /q "%CUR_DIR%\scw_old.txt" 
	if exist "%CUR_DIR%\scw_file.txt" del /f /q "%CUR_DIR%\scw_file.txt"
	if exist "%CUR_DIR%\scw.txt" del /f /q "%CUR_DIR%\scw.txt" 

	if exist "%CUR_DIR%\fmsclient_new.txt" del /f /q "%CUR_DIR%\fmsclient_new.txt" 
	if exist "%CUR_DIR%\fmsclient_old.txt" del /f /q "%CUR_DIR%\fmsclient_old.txt" 
	if exist "%CUR_DIR%\fmsclient_file.txt" del /f /q "%CUR_DIR%\fmsclient_file.txt" 
	if exist "%CUR_DIR%\fmsclient.txt" del /f /q "%CUR_DIR%\fmsclient.txt"
	
	echo Upgrading Installation Failed .
	echo Upgrading Installation Failed . >> %INSTALL_LOG%
	popd
	endlocal & exit /b 1
)

if exist "%CUR_DIR%\vah_new.txt"  del /f /q "%CUR_DIR%\vah_new.txt" 
if exist "%CUR_DIR%\vah_old.txt"  del /f /q "%CUR_DIR%\vah_old.txt"
if exist "%CUR_DIR%\vah_file.txt"  del /f /q "%CUR_DIR%\vah_file.txt" 
if exist "%CUR_DIR%\vah.txt"  del /f /q "%CUR_DIR%\vah.txt" 

if exist "%CUR_DIR%\scw_new.txt" del /f /q "%CUR_DIR%\scw_new.txt"
if exist "%CUR_DIR%\scw_old.txt" del /f /q "%CUR_DIR%\scw_old.txt" 
if exist "%CUR_DIR%\scw_file.txt" del /f /q "%CUR_DIR%\scw_file.txt"
if exist "%CUR_DIR%\scw.txt" del /f /q "%CUR_DIR%\scw.txt" 

if exist "%CUR_DIR%\fmsclient_new.txt" del /f /q "%CUR_DIR%\fmsclient_new.txt" 
if exist "%CUR_DIR%\fmsclient_old.txt" del /f /q "%CUR_DIR%\fmsclient_old.txt" 
if exist "%CUR_DIR%\fmsclient_file.txt" del /f /q "%CUR_DIR%\fmsclient_file.txt" 
if exist "%CUR_DIR%\fmsclient.txt" del /f /q "%CUR_DIR%\fmsclient.txt"

echo Fresh Installation Failed .
echo Fresh Installation Failed . >> %INSTALL_LOG%
popd
endlocal & exit /b 1

:PRECHECK
echo Precheck failed .
echo Precheck failed . >> %INSTALL_LOG%
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Precheck Failed                                           ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Precheck Failed                                           :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
popd
endlocal & exit /b 1

:END
echo Installation succeeds .
echo Installation succeeds . >> %INSTALL_LOG%
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::  Installation Succeeds                                     ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo. >> %INSTALL_LOG%
echo. >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
echo ::  Installation Succeeds                                     :: >> %INSTALL_LOG%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> %INSTALL_LOG%
popd
endlocal & exit /b 0


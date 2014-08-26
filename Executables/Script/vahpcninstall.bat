@echo off
Setlocal ENABLEDELAYEDEXPANSION

set PATCH_LIST=filelist.txt
set PCN=PCN005
set needfallback=0

if not "%~1"=="" set PCN=%~1
if not "%~2"=="" set PATCH_LIST=%~2

rem set current path to path where bat located.
pushd %~dp0
set CUR_DIR=%cd%
set PATCH_LIST="%CUR_DIR%\%PATCH_LIST%"
set LOG="%CUR_DIR%\vahpcninstall.log"
set VAH_ROOT=D:\ThomsonReuters
set VAH_DIR=D:\ThomsonReuters\VAH
set SMF_DIR=D:\ThomsonReuters\SMF
set VAH_FALLBACK_DIR=%VAH_DIR%\fallback\%PCN%
popd

echo Installing start ...
echo Installing start ... >%LOG%

echo. PCN : %PCN% >>%LOG%
echo. net stop smf...>>%LOG%
net stop smf

pushd %VAH_ROOT%

rem make fallback dir
echo. Creating fallback folder %VAH_FALLBACK_DIR%... >>%LOG%
if not exist %VAH_FALLBACK_DIR% mkdir %VAH_FALLBACK_DIR%

rem checking the patch list
if not exist %PATCH_LIST% (
	echo. Not found the patch list file ... >>%LOG%
	goto error
)

rem backup the vae0param.bin which contains the PCN version ,for fall back.
copy /y %SMF_DIR%\data\vae0param.bin %VAH_FALLBACK_DIR%
echo. vae0param.bin is backed up to %VAH_FALLBACK_DIR% >>%LOG%

rem backup the vae0stats.bin
copy /y %SMF_DIR%\data\vae0stats.bin %VAH_FALLBACK_DIR%
echo. vae0stats.bin is backed up to %VAH_FALLBACK_DIR% >>%LOG%

rem backup old file and override with new file
for /f "delims=: usebackq" %%I in (%PATCH_LIST%) do (
	echo. BACKUP %%~dpI%%~nxI
	echo.     TO %VAH_FALLBACK_DIR%\
	echo. BACKUP %%~dpI%%~nxI >>%LOG%
	echo.     TO %VAH_FALLBACK_DIR%\ >> %LOG%
	move /y %%~dpI%%~nxI %VAH_FALLBACK_DIR%
	
	echo.   COPY "%CUR_DIR%\%%~nxI" 
	echo.     TO %%~dpI 
	echo.   COPY "%CUR_DIR%\%%~nxI" >>%LOG%
	echo.     TO %%~dpI >>%LOG%
	copy /y "%CUR_DIR%\%%~nxI" %%~pI
)

set needfallback=1

echo Checking whether activatedlabelfile exists ...
echo Checking whether activatedlabelfile exists ... >> %LOG%
if exist "%VAH_DIR%\Config\activatedlabelfile" ( 
	echo Removing activatedlabelfile ...
    echo Removing activatedlabelfile ... >> %LOG%
	rd "%VAH_DIR%\Config\activatedlabelfile" /s /q
	echo Finished removing activatedlabelfile.
    echo Finished removing activatedlabelfile. >> %LOG%
)
	
echo. Auto configuration from manifest ... >> %LOG%
"%VAH_DIR%\Bin\cfgsync.exe"  >> %LOG%
if errorlevel 1 (
	echo. Auto Configuration Failed ... >> %LOG%
	goto error
)
	
echo re-generation SMF bin files . 
echo re-generation SMF bin files . >> %LOG%

pushd "%VAH_DIR%\Config"

PsdXml2Bin.exe "vae0stats.xml"
if errorlevel 1 (
	popd
	goto error
)

move /y "vae0stats.bin" "%SMF_DIR%\Data"
if errorlevel 1 (
	popd
	goto error
)

popd


echo Installing succeed ...
echo Installing succeed ... >>%LOG%
goto end

:error
echo Installing failed ...
echo Installing failed ... >>%LOG%

echo Fallback PCN ... 
echo Fallback PCN ... >>%LOG%
if %needfallback%==1 (
	for /f "delims=: usebackq" %%I in (%PATCH_LIST%) do (
	echo. Fallback %%~nxI To %%~dpI
	echo. Fallback %%~nxI To %%~dpI >> %LOG%
	
	move /y %VAH_FALLBACK_DIR%\%%~nxI %%~dpI
	)
	
	move /y "%VAH_FALLBACK_DIR%\vae0stats.bin" "%SMF_DIR%\Data"
)
popd
endlocal & exit /b 1

:end
echo. net start smf... >>%LOG%
net start smf

rem If the PCN version is defined in smf partition,overwrite the PCN version,which is to be reflected on SGC
hostmanager  -readparams /vae0/pcnversion |  findstr /i failed >nul
IF %ERRORLEVEL% EQU 1 ( 
hostmanager -writeparams /vae0/pcnversion=%PCN% as String >>%LOG%
)
 
popd
endlocal & exit /b 0

@echo on

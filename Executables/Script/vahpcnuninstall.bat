@echo off
Setlocal ENABLEDELAYEDEXPANSION

set PATCH_LIST=filelist.txt
set PCN=PCN005

if not "%~1"=="" set PCN=%~1
if not "%~2"=="" set PATCH_LIST=%~2


rem set current path to path where bat located.
pushd %~dp0
set CUR_DIR=%cd%
set PATCH_LIST="%CUR_DIR%\%PATCH_LIST%"
set LOG="%CUR_DIR%\vahpcnuninstall.log"
set VAH_ROOT=D:\ThomsonReuters
set VAH_DIR=D:\ThomsonReuters\VAH
set VAH_FALLBACK_DIR=%VAH_DIR%\fallback\%PCN%
popd

echo. Uninstalling start ...
echo. Uninstalling start ... >%LOG%

echo. PCN : %PCN% >>%LOG%
echo. net stop smf...>>%LOG%
net stop smf

pushd %VAH_ROOT%

rem check fallback dir
echo. Checking fallback folder ... >>%LOG%
if not exist %VAH_FALLBACK_DIR% (
	echo. Not found the fallback folder ... >>%LOG%
	goto error
)

rem checking the patch list
if not exist %PATCH_LIST% (
	echo. Not found the patch list file ... >>%LOG%
	goto error
)

rem backup old file and override with new file
for /f "delims=: usebackq" %%I in (%PATCH_LIST%) do (
	echo. ROOLBACK FROM %VAH_FALLBACK_DIR%\%%~nxI 
	echo.       TO %%~dpI
	echo. ROOLBACK FROM %VAH_FALLBACK_DIR%\%%~nxI >>%LOG%
	echo.       TO %%~dpI >>%LOG%
		
	if exist %VAH_FALLBACK_DIR%\%%~nxI (
	move /y %VAH_FALLBACK_DIR%\%%~nxI %%~dpI
	)
)

rem fallback the vae0param.bin 
if exist %VAH_FALLBACK_DIR%\vae0param.bin ( move /y %VAH_FALLBACK_DIR%\vae0param.bin %VAH_ROOT%\SMF\data )
echo. fallback vae0param.bin to %VAH_ROOT%\SMF\data >>%LOG%

rem fallback the vae0stats.bin 
if exist %VAH_FALLBACK_DIR%\vae0stats.bin ( move /y %VAH_FALLBACK_DIR%\vae0stats.bin %VAH_ROOT%\SMF\data )
echo. fallback vae0stats.bin to %VAH_ROOT%\SMF\data >>%LOG%

echo. Uninstalling succeed ... 
echo. Uninstalling succeed ... >>%LOG%
goto end

:error
echo. Uninstalling failed ... 
echo. Uninstalling failed ... >>%LOG%
popd
endlocal & exit /b 1

:end
echo. net start smf...>>%LOG%
net start smf
popd
endlocal & exit /b 0

@echo on

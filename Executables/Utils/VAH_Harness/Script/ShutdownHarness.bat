@echo off

tasklist /m RsslListener.dll 2>nul | findstr /i winlauncher>_tmp.log
if errorlevel 1 goto END

for /f "tokens=1-3 delims= " %%i in (_tmp.log) do (
    if /i "%%~ni"=="winlauncher" set pid=%%j
)
if defined pid taskkill /pid %pid% /f /t

:END
if exist _tmp.log del /f /q _tmp.log
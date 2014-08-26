@ECHO OFF
echo off
tasklist /m | find "rssllistener" > temp.txt
if %errorlevel% equ 0 (echo VAH Harness is running...
del temp.txt
pause) else (del temp.txt
"..\QF\WinLauncher.exe" -w "..\Config\VahHarnessStruct.xml")

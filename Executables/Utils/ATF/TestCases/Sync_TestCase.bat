@echo off

set ftpPath="%~dp0\..\LocalTools\psftp.exe"
set username=Reutadmin
set passwd=Tin.netSA
set RemoteIP=10.35.14.252

rem ---Sync a single file---
%ftpPath% -l %username% -pw %passwd% %RemoteIP% -b %~dp0\SyncFile.txt

rem ---Sync test case folder---
rem %ftpPath% -l %username% -pw %passwd% %RemoteIP% -b %~dp0\SyncFolder.txt
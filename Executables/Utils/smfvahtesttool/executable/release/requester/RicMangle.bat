@echo on
cd /d %~dp0 >nul
call rm -rf access_log*
call rm -rf error_log*
call rm -rf ignorelogtemp*
call SmfRequester.exe 127.0.0.1 8603 ..//commandsfile RicMangleCommand.xml RespFromServer.xml replace 5
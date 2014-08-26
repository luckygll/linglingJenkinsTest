@echo on
cd /d %~dp0 >nul
call rm -rf access_log*
call rm -rf error_log*
call rm -rf ignorelogtemp*
call SmfRequester.exe 10.35.54.175 8603 ..//commandsfile LoadCommand.xml RespFromServer.xml replace 5
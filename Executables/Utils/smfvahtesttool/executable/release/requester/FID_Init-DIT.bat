@echo on
cd /d %~dp0 >nul
call rm -rf access_log*
call rm -rf error_log*
call rm -rf ignorelogtemp*
call SmfRequester.exe 10.117.62.82 8603 ..//commandsfile FID_Init-DIT.xml RespFromServer.xml replace 5
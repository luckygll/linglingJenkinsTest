echo off

del/q access_log_*
del/q error_log__*
del/q ignorelogtemp_*
del/q rubbishlog

SmfRequester.exe 127.0.0.1 8603 ..//commandsfile Vad_Report.xml RespFromServer.xml replace 5
::SmfRequester.exe 127.0.0.1 8603 ..//commandsfile ActivateCommand.xml RespFromServer.xml replace 5
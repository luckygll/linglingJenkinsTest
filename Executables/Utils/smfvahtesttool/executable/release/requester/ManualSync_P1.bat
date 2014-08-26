del/q access_log_*
del/q error_log__*
del/q ignorelogtemp_*
del/q rubbishlog

@echo on
call SmfRequester.exe 127.0.0.1 8603 ..//commandsfile ManualSync_P1.xml RespFromServer.xml replace 1
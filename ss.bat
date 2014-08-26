@echo on
cd %~dp0
if exist yy (
 rmdir yy /F /Q /S )
mkdir yy
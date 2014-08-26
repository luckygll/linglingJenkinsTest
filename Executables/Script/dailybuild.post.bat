@echo off


:START
:: prerequisites subversion
:: ==================================================
svn --version >nul 2>nul
if errorlevel 1 echo [ERROR] subversion NOT found   & goto ERROR


:: revert svnrev.h
:: ==================================================
svn revert -q "..\..\Includes\svnrev.h"


:: revert VersionInfo.h
:: ==================================================
svn revert -q "..\..\Includes\VersionInfo.h"


goto END


:ERROR
exit /b 1

:END
exit /b 0

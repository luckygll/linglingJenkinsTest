@echo off

set totalTestCases=2

for /L %%i in (1,1,%totalTestCases%) do (
call runatf.bat p%%i
if not %%i==%totalTestCases% (
echo.
echo.
echo Ending current test case and start running the next case...)
copy ATF_Log.txt ATF_Log_%date:~0,2%-%date:~3,2%-%date:~6,4%_%time:~0,2%-%time:~3,2%-%time:~6,2%_%%i.txt
)
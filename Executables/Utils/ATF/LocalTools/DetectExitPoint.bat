@echo off

set ToolsPath=D:\ToolsProject\
set LogPath=D:\TestAutomation\RemoteTools\

rem %ToolsPath%EventAnalyzer.exe %LogPath%ess*.txt n
rem if not %errorlevel%==0 (echo Error Detected! > C:\Perferror.txt)

%ToolsPath%PerfLogAnalyzer.exe %LogPath%ss*.csv %LogPath%Baseline.xml 1
if not %errorlevel%==0 (echo Error Detected! > C:\Perferror.txt)
@echo on

set qf_ver=1.006.001
set drop_ver=0.4.0
if not "%~1"=="" set drop_ver=%~1

:START
:: prerequisites subversion
:: ==================================================
svn --version >nul 2>nul
if errorlevel 1 echo [ERROR] subversion NOT found   & goto ERROR


:: setup workspace directory
:: ==================================================
set workspace >nul 2>nul
if errorlevel 1 set WORKSPACE=%cd%\..\..\..
if exist "%WORKSPACE%\Package" rd /s /q "%WORKSPACE%\Package"
mkdir "%WORKSPACE%\Package"


:: housekeeping vah sdk on local working copy
:: ==================================================
if exist "..\..\SDK\include" rd /s /q "..\..\SDK\include"
if exist "..\..\SDK\lib"     rd /s /q "..\..\SDK\lib"
if exist "..\..\SDK\doc"     rd /s /q "..\..\SDK\doc"


:: get svn last changed revision
:: ==================================================
svn --version >nul 2>nul
if errorlevel 1 echo [ERROR] subversion NOT found & goto ERROR

set revision=
set svninfo=svn_info.log
svn info "%WORKSPACE%">"%svninfo%"
if errorlevel 1 goto ERROR

for /f "tokens=1,2 delims=:" %%i in (%svninfo%) do (
    if /i "%%i"=="Last Changed Rev" set revision=%%j
)
if "%revision%"=="" echo [ERROR] get svn last changed revision error & goto ERROR

echo %revision%>"%svninfo%"
for /f "delims= " %%i in (%svninfo%) do set revision=%%i
if exist "%svninfo%" del /f /q "%svninfo%"


:: update svnrev.h
:: ==================================================
set svnrev=..\..\Includes\svnrev.h
echo #ifndef __SVN_REV_H__>"%svnrev%"
echo #define __SVN_REV_H__>>"%svnrev%"
echo #define TAG_STR "trunk">>"%svnrev%"
echo #define SVN_REV %revision%>>"%svnrev%"
echo #define SVN_REVSTR "%revision%">>"%svnrev%"
echo #endif //__SNV_REV_H__>>"%svnrev%"


:: update VersionInfo.h
:: ==================================================
set year=%date:~6,4%
set drop_ver_log=%~n0_%drop_ver%.log
set major_ver=0
set minor_ver=4
set build_ver=0
echo %drop_ver%>"%drop_ver_log%"
for /f "tokens=1-3 delims=." %%i in (%drop_ver_log%) do (
    set major_ver=%%i
    set minor_ver=%%j
    set build_ver=%%k
)
del /f /q "%drop_ver_log%"

set verinfo=..\..\Includes\VersionInfo.h
echo #ifndef __VERSION_INFO_H__>"%verinfo%"
echo #define __VERSION_INFO_H__>>"%verinfo%"
echo #include "winver.h">>"%verinfo%"
echo #include "svnrev.h">>"%verinfo%"
echo.>>"%verinfo%"
echo #ifdef _DEBUG>>"%verinfo%"
echo #define FILE_FLAGS VS_FF_PRERELEASE^|VS_FF_PRIVATEBUILD^|VS_FF_DEBUG>>"%verinfo%"
echo #else>>"%verinfo%"
echo #define FILE_FLAGS VS_FF_PRERELEASE^|VS_FF_PRIVATEBUILD>>"%verinfo%"
echo #endif>>"%verinfo%"
echo.>>"%verinfo%"
echo #define PRODUCT_NAMESTRING "Elektron Value Add Infrastructure\0">>"%verinfo%"
echo #define COMPANY_NAMESTRING "Thomson Reuters Limited\0">>"%verinfo%"
echo #define LEGAL_COPYRIGHTSTRING "Copyright (c) %year%\0">>"%verinfo%"
echo.>>"%verinfo%"
echo #define PRIVATE_BUILDSTRING "Copyright (c) %year%\0">>"%verinfo%"
echo.>>"%verinfo%"
echo //for use in QF>>"%verinfo%"
echo #define QUANTUM_VERSIONSTRING "%qf_ver%">>"%verinfo%"
echo.>>"%verinfo%"
echo //for use in windows resources>>"%verinfo%"
echo #define ASSEMBLY_VERSIONSTRING "%drop_ver%." SVN_REVSTR>>"%verinfo%"
echo #define ASSEMBLY_MAJOR %major_ver% >>"%verinfo%"
echo #define ASSEMBLY_MINOR %minor_ver% >>"%verinfo%"
echo #define ASSEMBLY_BUILD %build_ver% >>"%verinfo%"
echo #define ASSEMBLY_REVISION SVN_REV>>"%verinfo%"
echo.>>"%verinfo%"
echo #define FILE_VERSIONSTRING "%drop_ver%." SVN_REVSTR>>"%verinfo%"
echo #define FILE_MAJOR %major_ver% >>"%verinfo%"
echo #define FILE_MINOR %minor_ver% >>"%verinfo%"
echo #define FILE_BUILD %build_ver% >>"%verinfo%"
echo #define FILE_REVISION SVN_REV>>"%verinfo%"
echo #endif>>"%verinfo%"

echo start to modify the version number of CfgSync assemblyInfo.cs
rem D:\VAH\SourceCode\Component\AutoConfigTool\Properties\AssemblyInfo.cs
rem D:\VAH\SourceCode\Executables\Script\dailybuild.pre.bat
rem ..\..\Includes\VersionInfo.h=D:\VAH\SourceCode\Includes
set CfgSync_AssemblyInfo=..\..\Component\AutoConfigTool\Properties\AssemblyInfo.cs
echo using System.Reflection; >%CfgSync_AssemblyInfo%
echo using System.Reflection; >>%CfgSync_AssemblyInfo%
echo using System.Runtime.CompilerServices; >>%CfgSync_AssemblyInfo%
echo using System.Runtime.InteropServices; >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyTitle("Manifest CfgSync Utility")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyDescription("")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyConfiguration("")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyCompany("Thomson Reuters Limited")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyProduct("Elektron Value Add Infrastructure")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyCopyright("Copyright (c) %year%\0")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyTrademark("")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyCulture("")] >>%CfgSync_AssemblyInfo%
echo [assembly: ComVisible(false)] >>%CfgSync_AssemblyInfo%
echo [assembly: Guid("91cc0c46-c07b-4bb4-b5e3-5d7b31e8e6eb")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyVersion("%drop_ver%.%revision%")] >>%CfgSync_AssemblyInfo%
echo [assembly: AssemblyFileVersion("%drop_ver%.%revision%")] >>%CfgSync_AssemblyInfo%

echo start to modify the version number of PreInstallCheck assemblyInfo.cs
set preIntall_AssemblyInfo=..\..\Component\PreInstallCheck\Properties\AssemblyInfo.cs
echo using System.Reflection; >%preIntall_AssemblyInfo%
echo using System.Reflection; >>%preIntall_AssemblyInfo%
echo using System.Runtime.CompilerServices; >>%preIntall_AssemblyInfo%
echo using System.Runtime.InteropServices; >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyTitle("PreInstallCheck Utility")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyDescription("")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyConfiguration("")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyCompany("Thomson Reuters Limited")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyProduct("Elektron Value Add Infrastructure")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyCopyright("Copyright (c) %year%\0")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyTrademark("")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyCulture("")] >>%preIntall_AssemblyInfo%
echo [assembly: ComVisible(false)] >>%preIntall_AssemblyInfo%
echo [assembly: Guid("91cc0c46-c07b-4bb4-b5e3-5d7b31e8e6eb")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyVersion("%drop_ver%.%revision%")] >>%preIntall_AssemblyInfo%
echo [assembly: AssemblyFileVersion("%drop_ver%.%revision%")] >>%preIntall_AssemblyInfo%

pause

goto END


:ERROR
exit /b 1

:END
exit /b 0

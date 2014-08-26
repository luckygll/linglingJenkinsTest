@echo off
setlocal

set config=debug
set platform=x64
set sdk_home=%cd%\..\..\SDK
set drop_ver=0.4.0

if not "%~1"=="" set config=%~1
if not "%~2"=="" set platform=%~2
if not "%~3"=="" set sdk_home=%~f3
if not "%~4"=="" set drop_ver=%~4

:START
set vah_home=%cd%\..\..
set utils=%cd%\..\Utils

:: prerequisites qf and zip
:: ==================================================
set quantum >nul 2>nul
if errorlevel 1 echo [ERROR] QF NOT setup  & goto ERROR
"%utils%\zip.exe" >nul 2>nul
if errorlevel 1 echo [ERROR] zip NOT found & goto ERROR


:: setup folder structure
:: ==================================================
if exist "%sdk_home%\include"                   rd /s /q "%sdk_home%\include"
if exist "%sdk_home%\lib\%platform%\%config%"   rd /s /q "%sdk_home%\lib\%platform%\%config%"
if exist "%sdk_home%\doc"                       rd /s /q "%sdk_home%\doc"
mkdir    "%sdk_home%\include"
mkdir    "%sdk_home%\lib\%platform%\%config%"
mkdir    "%sdk_home%\doc"


:: copy qf files to sdk
:: ==================================================
echo Copying QF header files pre-defined to SDK/include ...
xcopy "%QUANTUM_FRAMEWORK_DIR%\Includes\PreIncludeDefinitions.h"    "%sdk_home%\include"         /y /i /r
if errorlevel 1 goto ERROR

echo Copying QF header files TinyXML to SDK/include ...
xcopy "%QUANTUM_FRAMEWORK_DIR%\Includes\TinyXML\*"                  "%sdk_home%\include\TinyXML" /y /i /r
xcopy "%QUANTUM_FRAMEWORK_DIR%\Includes\TinyXmlDll.h"               "%sdk_home%\include"         /y /i /r
if errorlevel 1 goto ERROR

echo Copying QF header files trwf to SDK/include ...
xcopy "%QUANTUM_FRAMEWORK_DIR%\Includes\trwf\*"                     "%sdk_home%\include\trwf"    /y /i /r
if errorlevel 1 goto ERROR

echo Copying QF library files to SDK/lib/%platform%/%config% ...
xcopy "%QUANTUM_FRAMEWORK_DIR%\Libs\trwf\VC100\%platform%\%config%\*"                               "%sdk_home%\lib\%platform%\%config%"    /y /i /r
xcopy "%QUANTUM_FRAMEWORK_DIR%\Libs\rmds_cache\VC100\%platform%\%config%\libconvMfFidDb.lib"        "%sdk_home%\lib\%platform%\%config%"    /y /i /r
xcopy "%QUANTUM_FRAMEWORK_DIR%\Libs\rmds_cache\VC100\%platform%\%config%\libconvTrwfCache.lib"      "%sdk_home%\lib\%platform%\%config%"    /y /i /r
xcopy "%QUANTUM_FRAMEWORK_DIR%\Libs\rmds_cache\VC100\%platform%\%config%\libconvTrwfCacheApi.lib"   "%sdk_home%\lib\%platform%\%config%"    /y /i /r
xcopy "%QUANTUM_FRAMEWORK_DIR%\Libs\rmds_cache\VC100\%platform%\%config%\libcxxutPlat.lib"          "%sdk_home%\lib\%platform%\%config%"    /y /i /r
xcopy "%QUANTUM_FRAMEWORK_DIR%\Libs\rmds_cache\VC100\%platform%\%config%\libcxxutUtil.lib"          "%sdk_home%\lib\%platform%\%config%"    /y /i /r
xcopy "%QUANTUM_FRAMEWORK_DIR%\Build.out.%platform%\Lib\%config%\TinyXml.lib"                       "%sdk_home%\lib\%platform%\%config%"    /y /i /r
if errorlevel 1 goto ERROR


:: copy vah files to sdk
:: ==================================================
pushd "%vah_home%"
echo Copying VAH header files VAI to SDK/include ...
xcopy "Interfaces\VAI\*"                                            "%sdk_home%\include\VAI"                /y /i /r /e
xcopy "Includes\TypeConversionLib\*"                              	"%sdk_home%\include"                	/y /i /r /e
xcopy "Build.out.%platform%\Lib\%config%\VAHAllocator.lib"          "%sdk_home%\lib\%platform%\%config%"    /y /i /r
xcopy "Build.out.%platform%\Lib\%config%\TypeConversionLib.lib"     "%sdk_home%\lib\%platform%\%config%"    /y /i /r
if errorlevel 1 goto ERROR
popd

if /i "%vah_home%\SDK"=="%sdk_home%" goto END


:: prerequisites subversion
:: ==================================================
svn --version >nul 2>nul
if errorlevel 1 echo [ERROR] subversion NOT found   & goto ERROR


:: copy vah owned files to sdk
:: ==================================================
echo Copying VAH owned files to SDK ...
svn export --force "%vah_home%\SDK" "%sdk_home%"
if errorlevel 1 goto ERROR


:: copy vah chm documentation to sdk
:: ==================================================
echo Copying VAH chm documentation to SDK/doc ...
xcopy "%WORKSPACE%\Package\doxygen\VAHManual.chm" "%sdk_home%\doc" /y /i /r
if errorlevel 1 echo [WARNING]: VAH manual documentation NOT found


:: compress
:: ==================================================
pushd "%sdk_home%"
echo Compressing VAH SDK ...
set vah_sdk=VAH_SDK_V%drop_ver%.zip
if exist "..\%vah_sdk%" del /f /q "..\%vah_sdk%"
"%utils%\zip.exe" -r "..\%vah_sdk%" *
if errorlevel 1 goto ERROR

popd & goto END


:ERROR
echo ERROR!
endlocal & exit /b 1

:END
echo SUCCEED!
endlocal & exit /b 0

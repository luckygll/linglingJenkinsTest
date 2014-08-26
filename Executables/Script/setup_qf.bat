@echo off

:: HOWTO ::
:: Copy this setup_qf.bat to base directory of quantum framework, such as D:\work\SAMI\quantum_framework
:: Run setup_qf.bat by double-click directly
::

set framework_version=1.6.4.2
set boost_version=1.6.x_Boost_v_1_49

echo.
echo SETUP QUANTUM FRAMEWORK
echo.
echo FRAMEWORK  : %framework_version%
echo BOOST      : %boost_version%
echo.

:START
:: prerequisites vs2010, subversion and setx
:: ==================================================
path %VS100COMNTOOLS%..\IDE;%path%

devenv /? | findstr /i "version 10" >nul 2>nul
if errorlevel 1 echo [ERROR] VS2010 NOT found       & goto ERROR
svn --version >nul 2>nul
if errorlevel 1 echo [ERROR] subversion NOT found   & goto ERROR
setx /? >nul 2>nul
if errorlevel 1 echo [ERROR] setx NOT found         & goto ERROR


:: obtain quantum framework relevant codebase
:: ==================================================
set qf_home_url=https://sami.cdt.int.thomsonreuters.com/svn/quantum_framework

echo Checking out quantum framework tagged %framework_version% source codes ...
svn co %qf_home_url%/tags/Framework/FrameworkVersion%framework_version%     ./tags/Framework/FrameworkVersion%framework_version%
if errorlevel 1 echo [ERROR] check out framework source codes error & goto ERROR

echo Checking out boost tagged %boost_version% source codes ...
svn co %qf_home_url%/tags/Boost/FrameworkVersion%boost_version%             ./tags/Boost/FrameworkVersion%boost_version%
if errorlevel 1 echo [ERROR] check out boost source codes error & goto ERROR


:: set environment variables
:: ==================================================
set opt=
if exist "%systemroot%\syswow64" set opt=/m

echo Setting environment variables ...
set  QUANTUM_FRAMEWORK_DIR=%cd%\tags\Framework\FrameworkVersion%framework_version%\SourceCode
setx QUANTUM_FRAMEWORK_DIR %cd%\tags\Framework\FrameworkVersion%framework_version%\SourceCode %opt%>nul

set  QUANTUM_BOOST_DIR=%cd%\tags\Boost\FrameworkVersion%boost_version%
setx QUANTUM_BOOST_DIR %cd%\tags\Boost\FrameworkVersion%boost_version% %opt%>nul
if errorlevel 1 goto ERROR


:: build
:: ==================================================
set action=build
set config=debug
set platform=win32
if exist "%systemroot%\syswow64" set platform=x64

echo Building quantum framework %config%^|%platform% ...
devenv "%QUANTUM_FRAMEWORK_DIR%\MasterBuild\MasterBuildFramework2010.sln"   /%action% "%config%|%platform%"
if errorlevel 1 goto ERROR

echo Building unit test lib %config%^|%platform% ...
devenv "%QUANTUM_FRAMEWORK_DIR%\MasterBuild\MasterBuildUnitTestFramework2010.sln" /project QuantumUnitTestLib /%action% "%config%|%platform%"
if errorlevel 1 goto ERROR


:: install wizard
:: ==================================================
echo Installing quantum component and unit test wizard ...

set comp_vsz=Component Wizard.vsz
set test_vsz=UnitTestWizard.vsz
set wizard_ext=.ico, .vsdir, .vsz
set wizard_dst=%homeshare%\My Documents\Visual Studio 2010\Wizards
if exist "%systemroot%\syswow64" set wizard_dst=%userprofile%\Documents\Visual Studio 2010\Wizards

if not exist "%wizard_dst%" mkdir "%wizard_dst%"

:: update absolute path
pushd "%QUANTUM_FRAMEWORK_DIR%\Executables\Component Wizard2010"
echo VSWIZARD 7.0>"%comp_vsz%"
echo Wizard=VsWizard.VsWizardEngine.10.0>>"%comp_vsz%"
echo.>>"%comp_vsz%"
echo Param="WIZARD_NAME = Component Wizard">>"%comp_vsz%"
echo Param="ABSOLUTE_PATH = %cd%">>"%comp_vsz%"
echo Param="FALLBACK_LCID = 1033">>"%comp_vsz%"

for %%i in (%wizard_ext%) do xcopy "Component Wizard%%i" "%wizard_dst%" /y /i /r >nul
svn revert -q "%comp_vsz%"
popd

pushd "%QUANTUM_FRAMEWORK_DIR%\UnitTests\UnitTestWizard"
echo VSWIZARD 7.0>"%test_vsz%"
echo Wizard=VsWizard.VsWizardEngine.10.0>>"%test_vsz%"
echo.>>"%test_vsz%"
echo Param="WIZARD_NAME = Quantum UnitTest Wizard">>"%test_vsz%"
echo Param="ABSOLUTE_PATH = %cd%">>"%test_vsz%"
echo Param="FALLBACK_LCID = 1033">>"%test_vsz%"
echo Param="PROJECT_TYPE = VCPROJ">>"%test_vsz%"
echo Param="SOURCE_FILTER = cpp">>"%test_vsz%"
echo Param="HEADER_FILTER = h">>"%test_vsz%"
echo Param="CONFIG_FILTER = xml">>"%test_vsz%"

for %%i in (%wizard_ext%) do xcopy "UnitTestWizard%%i"   "%wizard_dst%" /y /i /r >nul
svn revert -q "%test_vsz%"
popd


goto END


:ERROR
echo ERROR!   & pause
exit /b 1

:END
echo SUCCEED! & pause
exit /b 0

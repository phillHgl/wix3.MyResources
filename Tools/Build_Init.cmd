@echo on
setlocal EnableDelayedExpansion

set _msbuild=%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild.exe
if [_msbuild]==[] (
  goto :errMBS
)

if not exist "%_msbuild%" (
  goto :errMBS
)
net session >nul 2>&1
if errorlevel 1 goto :errAdmin

call "%_msbuild%" ..\..\wix3\tools\OneTimeWixBuildInitialization.proj /l:FileLogger,Microsoft.Build.Engine;logfile=wix3_init.log
if errorlevel 1 goto :errBuild

::success
pause
exit /b 0


:errBuild
@echo MSBuild returned an error.  Please review the log file.
pause
exit 3
:errMBS
@echo MSBuild was not located.  This script will exit.
pause
exit 2
:errAdmin
@echo Failed: Elevated Permissions are required!
pause
exit 1
::endlocal implied

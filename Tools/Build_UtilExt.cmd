@echo off
setlocal
:set the window size
mode con: cols=210 lines=70

set _msbuild=%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild.exe
if [_msbuild]==[] (
  goto :errMBS
)

if not exist "%_msbuild%" (
  goto :errMBS
)

call "%_msbuild%" ..\..\wix3\src\ext\ca\ca.proj /m:1 /p:DebugSymbols=true /p:DebugType=full /p:Optimize=false /v:diag /l:FileLogger,Microsoft.Build.Engine;logfile="%~dp0\ext.log"
if errorlevel 1 goto :errBuild

call "%_msbuild%" ..\..\wix3\src\ext\UtilExtension\util.proj /m:1 /p:DebugSymbols=true /p:DebugType=full /p:Optimize=false /v:diag /l:FileLogger,Microsoft.Build.Engine;append;logfile="%~dp0\ext.log"
if errorlevel 1 goto :errBuild

::success
exit /b 0

:errBuild
@echo MSBuild returned an error.  Please review the log file.
pause
exit 2
:errMBS
@echo MSBuild was not located.  This script will exit.
pause
exit 1

::endlocal implied

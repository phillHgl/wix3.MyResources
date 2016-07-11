@echo off
setlocal
:set the window size
mode con: cols=210 lines=70

:: edit this path when the version of MSBuild (VS) is changed
set _msbuild=%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild.exe
if [_msbuild]==[] (
  goto :errMBS
)

if not exist "%_msbuild%" (
  goto :errMBS
)

:: added /p:PlatformToolset=v120_xp while trying to build wix39
call "%_msbuild%" ..\..\wix3\src\ext\ext.proj /p:DebugSymbols=true /p:DebugType=full /p:Optimize=false /v:diag /l:FileLogger,Microsoft.Build.Engine;logfile="%~dp0\ext.log"
if errorlevel 1 goto :errBuild
@echo 


:errBuild
@echo MSBuild returned an error.  Please review the log file.
pause
exit 2
:errMBS
@echo MSBuild was not located.  This script will exit.
pause
exit 1

::endlocal implied

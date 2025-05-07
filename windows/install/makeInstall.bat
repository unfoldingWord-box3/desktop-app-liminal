REM This script requires APP_VERSION environment variable to be set:
REM     You can do this in powershell by: $env:APP_VERSION = "0.2.6"
REM     Or in command prompt by: set APP_VERSION="0.2.6"

REM run from pankosmia directory by:  .\desktop-app-liminal\windows\install\makeInstall.bat

ECHO Version is %APP_VERSION%
REM Set the path to ISCC.exe, modify it if necessary
SET INNO_COMPILER_PATH="C:\Program Files (x86)\Inno Setup 6\ISCC.exe"

REM Path to the liminal.iss script file
SET SCRIPT_PATH="%~dp0liminal.iss"
SET OUTPUT_PATH="%~dp0..\..\releases\windows"

REM Run Inno Setup Compiler with the liminal.iss script
%INNO_COMPILER_PATH% -O"%OUTPUT_PATH%" %SCRIPT_PATH%

REM Check for errors
IF ERRORLEVEL 1 (
   echo Build failed with errors.
   exit /b 1
) ELSE (
   echo Build succeeded.
)

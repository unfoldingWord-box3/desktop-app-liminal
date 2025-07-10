@echo off
setlocal enabledelayedexpansion

echo ========================
echo Liminal starting up:
echo Current directory:
cd

REM Get the directory path that contains this script
set "SCRIPT_DIR=%~dp0"
echo Script directory: %SCRIPT_DIR%

REM Need to find server.bin - this is needed because working directory is not set

REM First look for server.bin relative to directory script is in
if exist "%SCRIPT_DIR%\..\bin\server.bin" (
    set "BASE=%SCRIPT_DIR%\.."
) else if exist ".\bin\server.bin" (
    set "BASE=."
) else if exist "..\bin\server.bin" (
    set "BASE=.."
) else if exist ".\Contents\bin\server.bin" (
    set "BASE=.\Contents"
) else if exist "C:\Program Files\Liminal\bin\server.bin" (
    set "BASE=C:\Program Files\Liminal"
) else (
    echo Error: server.bin not found in expected locations
    exit /b 1
)

echo bin folder found at %BASE%

REM Start electron
cd /d "%BASE%"
set "APP_RESOURCES_DIR=.\lib\"
.\electron\electron.exe .\electron

endlocal
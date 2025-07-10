# This script requires APP_VERSION environment variable to be set

param(
    [Parameter(Mandatory=$true)]
    [string]$arch
)

# Check if APP_VERSION environment variable is set
if (-not $env:APP_VERSION) {
    Write-Host "Error: APP_VERSION environment variable is not set."
    Write-Host "Set it in PowerShell using: `$env:APP_VERSION = '0.2.6'"
    exit 1
}

Write-Host "Version is $env:APP_VERSION"

# Clean up any existing installers
Get-ChildItem -Path "..\..\releases\windows\liminal_installer_*.exe" | Remove-Item -Force

# Change to build directory
Set-Location -Path "..\build" -ErrorAction Stop

# Create folder structure for package
Write-Host "Building folder structure for package..."

# Clean up and create project directories
Remove-Item -Path "..\temp\project" -Recurse -Force -ErrorAction SilentlyContinue
$projectPath = "..\temp\project"
$payloadPath = "$projectPath\payload\Liminal"

New-Item -ItemType Directory -Force -Path $payloadPath | Out-Null

# Copy electron files
Write-Host "Copying Electron files..."
$electronSrcPath = "..\buildResources\electron"
$electronDestPath = "$payloadPath\electron"
if (Test-Path $electronSrcPath) {
    Copy-Item -Path $electronSrcPath -Destination $electronDestPath -Recurse -Force
}

# Copy architecture-specific electron files
$archElectronPath = "..\temp\electron.$arch"
if (Test-Path $archElectronPath) {
    Copy-Item -Path "$archElectronPath\*" -Destination "$electronDestPath" -Recurse -Force
}

# Copy README
$readmeSrc = "..\buildResources\README.md"
$readmeDest = "$payloadPath\Resources"
if (Test-Path $readmeSrc) {
    New-Item -ItemType Directory -Force -Path $readmeDest | Out-Null
    Copy-Item -Path $readmeSrc -Destination "$readmeDest\README.md" -Force
}

# Copy bin and lib directories from build directory
if (Test-Path ".\bin") {
    Copy-Item -Path ".\bin" -Destination $payloadPath -Recurse -Force
}
if (Test-Path ".\lib") {
    Copy-Item -Path ".\lib" -Destination $payloadPath -Recurse -Force
}

# Create and copy scripts if needed
$scriptsPath = "$projectPath\scripts"
New-Item -ItemType Directory -Force -Path $scriptsPath | Out-Null

$postInstallSrc = "..\install\post_install_script.ps1"
if (Test-Path $postInstallSrc) {
    Copy-Item -Path $postInstallSrc -Destination "$scriptsPath\postinstall.ps1" -Force
}

# Call Inno Setup to create installer
Write-Host "Building installer..."
Set-Location -Path ".."

$innoSetupPath = "C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if (-not (Test-Path $innoSetupPath)) {
    Write-Host "Error: Inno Setup not found at $innoSetupPath"
    exit 1
}

$setupScript = ".\install\liminal.iss"
$outputPath = ".\releases\windows"

$process = Start-Process -FilePath $innoSetupPath -ArgumentList "/O`"$outputPath`"", $setupScript -NoNewWindow -Wait -PassThru
if ($process.ExitCode -ne 0) {
    Write-Host "Error: Inno Setup compilation failed"
    exit 1
}

Write-Host "Installation package created successfully"
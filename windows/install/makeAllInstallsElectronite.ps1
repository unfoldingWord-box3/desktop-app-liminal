
<#
.SYNOPSIS
    Creates Windows installation packages for Liminal application.

.DESCRIPTION
    This script automates the build process for Liminal Windows installers:
    - Downloads Electron and Liminal releases for specified architectures
    - Processes and packages the files
    - Creates installation packages for each supported architecture
    - Currently supports Intel64 architecture (ARM64 support is commented out)

.NOTES
    Requires PowerShell and depends on:
    - getElectronRelease.ps1
    - getLiminalRelease.ps1
    - makeInstallFromZipElectronite.ps1
#>

# Define URLs for different architectures
$LiminalIntel64 = "https://github.com/pankosmia/desktop-app-liminal/releases/download/v0.2.8/liminal-windows-v0.2.8.zip"
# $LiminalArm64 = "https://github.com/pankosmia/desktop-app-liminal/releases/download/v0.2.8/liminal-macos-mx-v0.2.8.zip"
$ElectronArm64 = "https://github.com/unfoldingWord/electronite/releases/download/v37.1.0-graphite/electronite-v37.1.0-graphite-win32-arm64.zip"
$ElectronIntel64 = "https://github.com/unfoldingWord/electronite/releases/download/v37.1.0-graphite/electronite-v37.1.0-graphite-win32-x64.zip"

# Loop through architectures
# foreach ($ARCH in @("intel64", "arm64")) {

foreach ($ARCH in @("intel64")) {
    Write-Host "Building for architecture: $ARCH"

    # Set download URLs based on architecture
    $downloadLiminalUrl = $LiminalIntel64
    $downloadElectronUrl = $ElectronIntel64

    if ($ARCH -eq "arm64") {
        $downloadLiminalUrl = $LiminalArm64
        $downloadElectronUrl = $ElectronArm64
    }

    # Get Electron release
    Write-Host "Getting Electron release..."
    $electronResult = & "$PSScriptRoot\getElectronRelease.ps1" -downloadUrl $downloadElectronUrl -arch $ARCH
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Failed to get Electron release files at $downloadElectronUrl"
        exit 1
    }

    # Get Liminal release
    Write-Host "Getting Liminal release..."
    $liminalResult = & "$PSScriptRoot\getLiminalRelease.ps1" -downloadUrl $downloadLiminalUrl -arch $ARCH
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Failed to get Liminal release files at $downloadLiminalUrl"
        exit 1
    }

    # Make install from zip
    Write-Host "Creating install package..."
    $zipPath = Resolve-Path "..\temp\zips\$ARCH\liminal*.zip"
    $installResult = & "$PSScriptRoot\makeInstallElectroniteFromZip.ps1" -zipPath $zipPath -destinationFolder "..\temp\release" -arch $ARCH
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Build failed for architecture $ARCH"
        exit 1
    }
}

Write-Host "All architectures built successfully"
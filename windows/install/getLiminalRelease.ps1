

<#
.SYNOPSIS
Downloads Liminal release package for specified architecture.

.DESCRIPTION
This PowerShell script downloads a Liminal release package from a provided URL for a specific architecture.
It performs the following tasks:
- Extracts version information from the filename using getVersion.ps1
- Creates necessary directories for downloaded files
- Downloads the package if it doesn't already exist
- Handles errors during download process

.PARAMETER downloadUrl
The URL from which to download the Liminal package

.PARAMETER arch
The target architecture for the download (e.g., x64, arm64)
#>

# Check if filename and destination are provided as arguments
param(
    [Parameter(Mandatory=$true)]
    [string]$downloadUrl,

    [Parameter(Mandatory=$true)]
    [string]$arch
)

# Extract filename from URL
$filename = Split-Path $downloadUrl -Leaf
Write-Host "filename is $filename"

# Source the version script and execute it
# Note: We need to dot-source to keep variables in current scope
$scriptPath = Join-Path $PSScriptRoot "getVersion.ps1"
if (Test-Path $scriptPath) {
    . $scriptPath -filename $filename
}
else {
    Write-Host "Error: getVersion.ps1 script not found"
    exit 1
}

# Check if a version was extracted
if ([string]::IsNullOrEmpty($env:APP_VERSION)) {
    Write-Host "Error: Unable to extract version from file name '$downloadUrl'."
    exit 1
}

Write-Host "Fetching for architecture: $arch from $downloadUrl"

# Create directory for downloaded files
$destPath = "..\temp\zips\$arch"
New-Item -ItemType Directory -Force -Path $destPath | Out-Null

# Check if file already exists
$dest = Join-Path $destPath $filename
if (Test-Path $dest) {
    Write-Host "File already exists at $dest, skipping download"
    exit 0
}

# Download zip file
Write-Host "Downloading $arch package..."
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $dest
    Write-Host "Successfully downloaded to $dest"
}
catch {
    Write-Host "Error: Failed to download $downloadUrl package to $dest - $($_.Exception.Message)"
    exit 1
}
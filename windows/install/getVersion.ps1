param(
    [Parameter(Mandatory=$true)]
    [string]$filename
)

# Extract version number using regex
$version = if ($filename -match 'v(\d+\.\d+\.\d+)') {
    $matches[1]
} else {
    $null
}

# Check if a version was extracted
if ([string]::IsNullOrEmpty($version)) {
    Write-Host "Error: Unable to extract version from file name '$filename'."
    exit 1
}

# Print the extracted version
Write-Host "Extracted version: $version"

# Set APP_VERSION environment variable
$env:APP_VERSION = $version

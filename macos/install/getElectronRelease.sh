#!/bin/sh

# Check if filename and destination are provided as an argument
if [ -z "$2" ]; then
  echo "Usage: $0 <downloadUrl> <arch>"
  exit 1
fi

# get arguments
downloadUrl="$1"
arch="$2"

testDir="../temp/electron.$arch/Electron.app"
if [ -d "$testDir" ]; then
  echo "Electron.app already exists for $arch"
  exit 0
fi

# Extract filename from URL
filename=${downloadUrl##*/}
echo "filename is $filename"

echo "Fetching for architecture: $arch from $downloadUrl"

# Create directory for downloaded files
destFolder="../temp/electron/$arch"
mkdir -p "$destFolder"

# Download zip file
tempName="$destFolder/temp.zip"
echo "Downloading $arch package to $tempName"
curl -L "$downloadUrl" -o "$tempName"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download $downloadUrl package to $tempName - $?"
    exit 1
fi

# create destination directory
unzipDest="../temp/electron.$arch"
rm -rf "$dest"

# Unzip the file
if ! unzip "$tempName" -d "$unzipDest"; then
  echo "Error: Failed to unzip '$unzipDest'"
  exit 1
fi

echo "Successfully unzipped to: $unzipDest"


    

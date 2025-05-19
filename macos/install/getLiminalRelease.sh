#!/bin/sh

# Check if filename and destination are provided as an argument
if [ -z "$2" ]; then
  echo "Usage: $0 <downloadUrl> <arch>"
  exit 1
fi

# get arguments
downloadUrl="$1"
arch="$2"

# Extract filename from URL
filename=${downloadUrl##*/}
echo "filename is $filename"

# do source so environment variables persist
source ./getVersion.sh $filename

# Check if a version was extracted; if not, show an error
if [ -z "$APP_VERSION" ]; then
  echo "Error: Unable to extract version from file name '$downloadUrl'."
  exit 1
fi

echo "Fetching for architecture: $arch from $downloadUrl"

# Create directory for downloaded files
mkdir -p "../temp/zips/$arch"

# Download zip file
echo "Downloading $arch package..."
dest="../temp/zips/$arch/$filename"
curl -L "$downloadUrl" -o "$dest"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download $downloadUrl package to $dest - $?"
    exit 1
fi


    

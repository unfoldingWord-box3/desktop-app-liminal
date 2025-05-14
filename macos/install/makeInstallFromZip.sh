#!/bin/sh

# Check if filename and destination are provided as an argument
if [ -z "$3" ]; then
  echo "Usage: $0 <filename> <destination-folder> <arch>"
  exit 1
fi

# get arguments
filename="$1"
destination="$2/$3"
arch="$3"

echo "Processing '$filename'"

# do source so environment variables persist
source ./getVersion.sh $filename

# Check if a version was extracted; if not, show an error
if [ -z "$APP_VERSION" ]; then
  echo "Error: Unable to extract version from file name '$filename'."
  exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Unzip the file
if ! unzip "$filename" -d "$TEMP_DIR"; then
  echo "Error: Failed to unzip '$filename'"
  rm -rf "$TEMP_DIR"
  exit 1
fi

echo "Successfully unzipped to: $TEMP_DIR"

rm -rf ../build
mkdir -p ../build
cp -R "$TEMP_DIR"/* ../build/

./makeInstall.sh $arch

rm -rf "$destination"
mkdir -p "$destination"
cp ../../releases/macos/liminal_installer_*.pkg "$destination"
echo "Files at $destination"
ls -als "$destination/"


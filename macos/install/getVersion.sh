#!/bin/sh

# Check if a filename is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# File name provided as the first argument (including path)
filename="$1"

# Extract version number
version=$(echo "$filename" | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+')

# remove the leading 'v'
version=${version#v}

# Check if a version was extracted; if not, show an error
if [ -z "$version" ]; then
  echo "Error: Unable to extract version from file name '$filename'."
  exit 1
fi

# Print the extracted version
echo "Extracted version: $version"

# Set APP_VERSION environment variable
export APP_VERSION="$version"


#!/bin/sh

# Loop through creating installs for both arm64 and intel64
for ARCH in "arm64" "intel64"; do
    echo "Building for architecture: $ARCH"
    
    # unzip zip the liminal install files and create mac install package
    ./makeInstallFromZip.sh  zips/$ARCH/liminal*.zip ../release/$ARCH
    
    if [ $? -ne 0 ]; then
        echo "Error: Build failed for architecture $ARCH"
        exit 1
    fi
done

echo "All architectures built successfully"

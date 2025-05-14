#!/bin/sh

# Loop through different architectures
for ARCH in "arm64" "intel64"; do
    echo "Building for architecture: $ARCH"
    
    # Call makeInstall script
    ./makeInstallFromZip.sh  zips/$ARCH/liminal*.zip ../release/$ARCH
    
    if [ $? -ne 0 ]; then
        echo "Error: Build failed for architecture $ARCH"
        exit 1
    fi
done

echo "All architectures built successfully"

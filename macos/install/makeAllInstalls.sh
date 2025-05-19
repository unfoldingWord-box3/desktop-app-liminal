#!/bin/sh

LiminalIntel64="https://github.com/pankosmia/desktop-app-liminal/releases/download/v0.2.8/liminal-macos-intel64-v0.2.8.zip"

LiminalArm64="https://github.com/pankosmia/desktop-app-liminal/releases/download/v0.2.8/liminal-macos-mx-v0.2.8.zip"

ElectronArm64="https://github.com/unfoldingWord/electronite/releases/download/v25.3.2-graphite/electronite-v25.3.2-graphite-darwin-arm64.zip"

ElectronIntel64="https://github.com/unfoldingWord/electronite/releases/download/v25.3.2-graphite/electronite-v25.3.2-graphite-darwin-x64.zip"

# Loop through creating installs for both arm64 and intel64
for ARCH in "intel64" "arm64"; do
    echo "Building for architecture: $ARCH"
  
    downloadLiminalUrl="$LiminalIntel64"
    downloadElectronUrl="$ElectronIntel64"
    if [ "$ARCH" = "arm64" ]; then
        downloadLiminalUrl="$LiminalArm64" 
        downloadElectronUrl="$ElectronArm64"
    fi
      if [ "$ARCH" = "intel64" ]; then
          downloadLiminalUrl="$LiminalIntel64" 
          downloadElectronUrl="$ElectronIntel64"
      fi

    ./getElectronRelease.sh  $downloadElectronUrl $ARCH
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to get Electron release files at downloadElectronUrl - $?"
        exit 1
    fi
    
    ./getLiminalRelease.sh  $downloadLiminalUrl $ARCH
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to get Liminal release files at $downloadLiminalUrl"
        exit 1
    fi
    
    # unzip the liminal install files and create mac install package
    ./makeInstallFromZip.sh  ../temp/zips/$ARCH/liminal*.zip ../temp/release $ARCH
    
    if [ $? -ne 0 ]; then
        echo "Error: Build failed for architecture $ARCH"
        exit 1
    fi
done

echo "All architectures built successfully"

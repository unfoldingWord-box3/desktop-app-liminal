#!/bin/sh

# environment variable must be set
#   for example do `export APP_VERSION="0.2.7"` before calling script

# requires shc - do `brew install shc`

# Check if APP_VERSION environment variable is set
if [ -z "$APP_VERSION" ]; then
    echo "Error: APP_VERSION environment variable is not set."
    exit 1
fi

arch="$1"

rm -f ../../releases/macos/liminal_installer_*.pkg

cd ../build || exit 1

########################################
# build folder structure for package

# Turn on command echo
set -x

rm -rf ../project

mkdir -p ../project/payload/Liminal.app/Contents/MacOS

# convert shell script to app
#rm -f ../buildResources/appLauncher.sh.x.c
#shc -f ../buildResources/appLauncher.sh -o ../project/payload/Liminal.app/Contents/MacOS/startLiminal
#chmod 555 ../project/payload/Liminal.app/Contents/MacOS/startLiminal

## non-electron startup
# cp ../buildResources/appLauncher.sh ../project/payload/Liminal.app/Contents/MacOS/startLiminal.sh

# electron startup
cp ../buildResources/appLauncherElectron.sh ../project/payload/Liminal.app/Contents/MacOS/startLiminal.sh
# copy shared electron files
cp -R ../buildResources/electron ../project/payload/Liminal.app/Contents/
# now copy architecture specific electron files
cp -R ../buildResources/electron.$arch/* ../project/payload/Liminal.app/Contents/electron

# Check if Electron executable owner is current user
ELECTRON_OWNER=$(stat -f %u ../project/payload/Liminal.app/Contents/electron/Electron.app/Contents/MacOS/Electron)
CURRENT_USER=$(id -u)
if [ "$ELECTRON_OWNER" != "$CURRENT_USER" ]; then
    echo "Error: Electron executable owner is not current user. Please run: sudo chown -R $(id -u):$(id -g) ../buildResources/electron.$arch/*"
    exit 1
fi

# rename Electron.app folder 
mv ../project/payload/Liminal.app/Contents/electron/Electron.app ../project/payload/Liminal.app/Contents/electron/Electron

chmod 755 ../project/payload/Liminal.app/Contents/electron/Electron/Contents/MacOS/Electron

mkdir -p ../project/payload/Liminal.app/Contents/Resources
cp ../buildResources/README.md ../project/payload/Liminal.app/Contents/Resources/README.md

# add APP_VERSION to Info.plist
cp ../buildResources/Info.plist ../project/payload/Liminal.app/Contents/
PLIST_FILE="../project/payload/Liminal.app/Contents/Info.plist"

# Check if the file exists
if [ ! -f "$PLIST_FILE" ]; then
    echo "Error: $PLIST_FILE does not exist."
    exit 1
fi

# Replace all occurrences of ${APP_VERSION} with the value of the APP_VERSION variable
sed -i.bak "s/\${APP_VERSION}/$APP_VERSION/g" "$PLIST_FILE"

# Print success message
echo "Replaced \${APP_VERSION} with \"$APP_VERSION\" in $PLIST_FILE."
#echo "Backup of original file saved as $PLIST_FILE.bak"
#remove backup
rm "$PLIST_FILE.bak"

cp -R ./bin ../project/payload/Liminal.app/Contents/
chmod 755 ../project/payload/Liminal.app/Contents/bin/server.bin
chmod 755 ../project/payload/Liminal.app/Contents/MacOS/startLiminal.sh

cp -R ./lib ../project/payload/Liminal.app/Contents/

mkdir -p ../project/scripts
cp ../install/post_install_script.sh ../project/scripts/postinstall
chmod +x ../project/scripts/postinstall

# set execute permission on all folders
find ../project/payload/Liminal.app/ -type d -exec chmod u+x,g+x,o+x {} +

# build pkg
cd ..
pkgbuild \
  --root ./project/payload \
  --scripts ./project/scripts \
  --identifier com.yourdomain.liminal \
  --version "$APP_VERSION" \
  --install-location /Applications \
  ./build/liminal_installer_${arch}_${APP_VERSION}.pkg

# copy to releases folder
cp ./build/liminal_installer_${arch}_${APP_VERSION}.pkg ../releases/macos/

#!/usr/bin/env zsh

# environment variable must be set
#   for example do `export APP_VERSION="0.2.7"` before calling script

rm -f ../../releases/macos/liminal_installer_*.pkg

cd ../build

########################################
# build folder structure for package

# Turn on command echo
set -x

rm -rf ../project

mkdir -p ../project/payload/Liminal.app/Contents/MacOS
cp ../buildResources/appLauncher.zsh ../project/payload/Liminal.app/Contents/MacOS/liminal.zsh
chmod 555 ../project/payload/Liminal.app/Contents/MacOS/liminal.zsh

mkdir -p ../project/payload/Liminal.app/Contents/Resources
cp ../buildResources/README.md ../project/payload/Liminal.app/Contents/Resources/README.md

cp ../buildResources/Info.plist ../project/payload/Liminal.app/Contents/

cp -R ./bin ../project/payload/Liminal.app/Contents/
chmod 755 ../project/payload/Liminal.app/Contents/bin/server.bin

cp -R ./lib ../project/payload/Liminal.app/Contents/

mkdir -p ../project/scripts
cp ../install/post_install_script.sh ../project/scripts/postinstall
chmod +x ../project/scripts/postinstall

# build pkg
cd ..
pkgbuild \
  --root ./project/payload \
  --scripts ./project/scripts \
  --identifier com.yourdomain.liminal \
  --version ${APP_VERSION} \
  --install-location /Applications \
  ./project/liminal_installer_${APP_VERSION}.pkg

# copy to releases folder
cp ./project/liminal_installer_${APP_VERSION}.pkg ../releases/macos/

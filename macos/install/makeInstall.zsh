#!/usr/bin/env zsh

cd ../build

########################################
# build folder structure for package

mkdir -p ../project/payload/Liminal.app/Contents/MacOS
cp ../buildResources/appLauncher.zsh ../project/payload/Liminal.app/Contents/MacOS/liminal.zsh
chmod 555 ../project/payload/Liminal.app/Contents/MacOS/liminal.zsh

mkdir -p ../project/payload/Liminal.app/Contents/Resources
cp ../buildResources/README.md ../project/payload/Liminal.app/Contents/Resources/README.md

cp -R ./bin ../project/payload/Liminal.app/Contents/
chmod 755 ../project/payload/Liminal.app/Contents/bin/server.bin

cp -R ./lib ../project/payload/Liminal.app/Contents/

mkdir -p ../project/scripts
cp ../install/post_install_script.sh ../project/scripts/postinstall
chmod +x ../project/scripts/postinstall

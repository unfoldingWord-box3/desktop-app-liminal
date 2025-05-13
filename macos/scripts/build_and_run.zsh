#!/usr/bin/env zsh

set -e
set -u

if [ ! -f ../../local_server/target/debug/local_server ]; then
    echo "Building local server"
    cd ../../local_server
    OPENSSL_STATIC=yes cargo build --release
    cd ../macos/scripts
fi

echo "Assembling build environment"
node ./build.js

echo "Running..."
cd ../build
./liminal.zsh

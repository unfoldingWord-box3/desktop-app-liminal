if [ ! -f ../../local_server/target/debug/local_server ]; then
    echo "Building local server"
    cd ../../local_server
    cargo build --release
    cd ../windows/scripts
fi

echo "Assembling build environment"
node ./build.js

echo "Running..."
cd ../build
./liminal.bat

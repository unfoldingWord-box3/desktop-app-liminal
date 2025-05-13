if not exist ../../local_server/target/debug/local_server (
    echo "Building local server"
    cd ../../local_server
    cargo build --release
    cd ../windows/scripts
)

echo "Assembling build environment"
node ./build.js

echo "Running..."
cd ../build
./liminal.bat

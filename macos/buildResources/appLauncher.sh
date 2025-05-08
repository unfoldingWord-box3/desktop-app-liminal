#!/bin/sh

clear
# Check for server.bin in ./bin first, then ../bin
if [ -e ./bin/server.bin ]; then
    BASE="."
elif [ -e ../bin/server.bin ]; then
    BASE=".."
elif [ -e ./Contents/bin/server.bin ]; then
    BASE="./Contents"
else
    echo "Error: server.bin not found in ./bin or ../bin"
    exit 1
fi

# launch browser
URL="http://localhost:8000"
if [ -e /Applications/Firefox.app ]
then
    echo "Launching Firefox"
    open -a firefox -g "$URL" &
else
    echo "Launching Default browser"
    open "$URL" &
fi


echo "bin folder found at $BASE"
echo "Launch a web browser and enter http://localhost:8000"
echo "(Best viewed with a Graphite-enabled browser such as Firefox.)"
echo " "
cd $BASE
export APP_RESOURCES_DIR=./lib/
./bin/server.bin
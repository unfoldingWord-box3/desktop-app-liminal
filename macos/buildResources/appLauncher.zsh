#!/usr/bin/env zsh

clear
# Check for server.bin in ./bin first, then ../bin
if [ -e ./bin/server.bin ]; then
    BASE="."
elif [ -e ../bin/server.bin ]; then
    BASE=".."
else
    echo "Error: server.bin not found in ./bin or ../bin"
    exit 1
fi

echo "bin folder found at ${BASE}"
echo "Launch a web browser and enter http://localhost:8000"
echo "(Best viewed with a Graphite-enabled browser such as Firefox.)"
echo " "
export APP_RESOURCES_DIR=${BASE}/lib/
${BASE}/bin/server.bin &

URL="http://localhost:8000"
if [ -e /Applications/Firefox.app ]
then
    open -a firefox -g "$URL" &
else
    open "$URL" &
fi

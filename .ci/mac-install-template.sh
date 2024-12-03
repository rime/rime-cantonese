#!/bin/bash
# macOS Squirrel frontend + cantonese schema installation script
# Author
#   - tanxpyox <tanxpyox@gmail.com>

RIMEDIR=~/Library/Rime/

sudo installer -verbose -pkg ./Squirrel-${SQUIRREL_VERSION}.pkg -target /

# check for user lib
if [ ! -d ${RIMEDIR} ]; then
    mkdir ${RIMEDIR}
fi

echo Installing IME files...
curl -fsSL https://git.io/rime-install | bash -s -- ${SQUIRREL_PACKAGES}


echo Done!

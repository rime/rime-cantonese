#!/bin/bash
# macOS Squirrel frontend + cantonese schema installation script
# Author
#   - tanxpyox <tanxpyox@gmail.com>

@echo off
RIMEDIR=~/Library/Rime/

sudo installer -pkg ./Squirrel.pkg

# check for user lib
if [ ! -d ${RIMEDIR} ]; then
    mkdir ${RIMEDIR}
fi

echo Installing IME files...
curl -fsSL https://git.io/rime-install | bash -s -- cantonese emoji sgalal/rime-opencc-latest custom:set:config=default,key=installed_from,value=rime-cantonese custom:add:schema=jyut6ping3


echo Done!

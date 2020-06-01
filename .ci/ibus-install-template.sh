#!/bin/bash
# For Ubuntu and derivatives thereof
# Linux ibus frontend + Cantonese schema installation script
# Author
#   - tanxpyox <tanxpyox@gmail.com>

RIMEDIR=~/.config/ibus/rime/

echo Installing ibus-rime frontend ...
sudo apt-get install curl git ibus-rime -y

# check for user lib
if [ ! -d ${RIMEDIR} ]; then
    mkdir ${RIMEDIR}
fi

echo Installing IME files ...
curl -fsSL https://git.io/rime-install | bash -s -- ${IBUS_PACKAGES}

echo Done!

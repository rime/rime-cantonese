#!/bin/bash
# Linux ibus frontend + Cantonese schema installation script
# Author
#   - tanxpyox <tanxpyox@gmail.com>

@echo off
RIMEDIR=~/.config/ibus/rime/

# install ibus frontend
sudo apt-get install curl git ibus-rime -y

# check for user lib
if [ ! -d ${RIMEDIR} ]; then
    mkdir ${RIMEDIR}
fi

# install plum jyut6ping3 schema and related files
curl -fsSL https://git.io/rime-install | bash -s -- :preset emoji sgalal/rime-opencc-latest cantonese custom:set:config=default,key=patch/any_key,value=any_value custom:add:schema=jyut6ping3

ibus restart





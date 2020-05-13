#!/bin/bash
# macOS Squirrel frontend + cantonese schema installation script
# Author
#   - tanxpyox <tanxpyox@gmail.com>

@echo off
RIMEDIR=~/Library/rime/

# install homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh

# install squirrel frontend
brew cask install squirrel 

# check for user lib
if [ ! -d ${RIMEDIR} ]; then
    mkdir ${RIMEDIR}
fi

# install plum jyut6ping3 schema and related files
curl -fsSL https://git.io/rime-install | bash -s -- :preset emoji sgalal/rime-opencc-latest cantonese custom:set:config=default,key=patch/any_key,value=any_value custom:add:schema=jyut6ping3

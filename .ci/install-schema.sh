#!/bin/bash

curl -fsSL https://git.io/rime-install | bash -s -- rime/rime-cantonese@install/clean-install-packages.conf
rm clean-install-packages.conf

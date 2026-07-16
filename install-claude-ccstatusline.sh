#!/bin/bash

npx -y ccstatusline@latest

TARGET="$HOME/.config/ccstatusline/settings.json"
mkdir -p $(dirname "$TARGET")
ln -s --backup=numbered "$(realpath ccstatusline.settings.json)" "$TARGET"

#!/bin/bash

TARGET="$HOME/.config/efm-langserver/config.yaml"
mkdir -p $(dirname "$TARGET")
ln -s --backup=numbered "$(realpath nvim.efm-langserver.config.yaml)" "$TARGET"


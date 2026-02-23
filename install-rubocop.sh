#!/bin/bash

TARGET="$HOME/.config/rubocop/config.yml"
mkdir -p $(dirname "$TARGET")
ln -s --backup=numbered "$(realpath rubocop.yml)" "$TARGET"

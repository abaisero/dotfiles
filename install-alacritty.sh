#!/bin/bash

source ./shell-utils

echo_info Install Alacritty terminal emulator from https://github.com/alacritty/alacritty

TARGET="$HOME/.config/alacritty/alacritty.toml"
mkdir -p $(dirname "$TARGET")
ln -s --backup=numbered "$(realpath alacritty.toml)" "$TARGET"

TARGET="$HOME/.config/alacritty/cyberdream.toml"
wget https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/refs/heads/main/extras/alacritty/cyberdream.toml -O "$TARGET"

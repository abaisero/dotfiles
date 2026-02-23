#!/bin/bash

TARGET="$HOME/.config/zathura/zathurarc"
mkdir -p $(dirname "$TARGET")
ln -s --backup=numbered $(realpath zathurarc) "$TARGET"

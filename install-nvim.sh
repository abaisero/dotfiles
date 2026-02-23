#!/bin/bash

TARGET="$HOME/.config/nvim"
bk "$TARGET"
git clone git@github.com:abaisero/kickstart.nvim.git "$TARGET"

#!/bin/bash

programs=(
  flameshot
  fzf
  git
  git-flow
  python-is-python3
  python3-venv
  ripgrep
  tmux
)

sudo apt install "${programs[@]}"

source ./shell-utils

echo_info "Install manually from the corresponding repos:"
echo_info "- Alacritty git@github.com:alacritty/alacritty.git"
echo_info "- Neovim    git@github.com:neovim/neovim.git"
echo_info "- Typst     git@github.com:typst/typst.git"
echo_info "- z         git@github.com:rupa/z.git"


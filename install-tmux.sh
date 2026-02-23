#!/bin/bash

ln -s --backup=numbered "$(realpath tmux.conf)" "$HOME/.tmux.conf"
ln -s --backup=numbered "$(realpath tmux.sessions)" "$HOME/.tmux.sessions"

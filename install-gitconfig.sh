#!/bin/bash

ln -s --backup=numbered  "$(realpath gitconfig)" "$HOME/.gitconfig"


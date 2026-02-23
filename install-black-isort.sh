#!/bin/bash

ln -s --backup=numbered "$(realpath black)" "$HOME/.config/black"
ln -s --backup=numbered "$(realpath isort.cfg)" "$HOME/.isort.cfg"

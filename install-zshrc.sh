#!/bin/bash

ln -s --backup=numbered "$(realpath zshrc)" "$HOME/.zshrc"

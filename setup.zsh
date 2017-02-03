#!/bin/bash

sudo apt-get install zsh

usermod -s $(which zsh) $USER
chsh -s $(which zsh) $USER

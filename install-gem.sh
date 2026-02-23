#!/bin/bash

ln -s --backup=numbered "$(realpath gemrc)" "$HOME/.gemrc"

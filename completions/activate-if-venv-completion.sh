#!/bin/bash

_activate_if_venv_completions() {
  for venvs in $(list-venvs); do
    COMPREPLY+=("$venvs")
  done
}

complete -F _activate_if_venv_completions activate-if-venv

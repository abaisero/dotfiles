#!/bin/bash

_s_completions() {
  for session_source_file in $(find $HOME/.tmux.sessions/ -name '*.conf'); do
    session_name=$(basename -s .conf $session_source_file)
    COMPREPLY+=($session_name)
  done
}

complete -F _s_completions s

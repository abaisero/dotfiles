#!/bin/bash

GTD_SUBCOMMANDS_FILTERLESS=(
  capture
)

GTD_SUBCOMMANDS_POSTFILTER=(
  tickle
  incubate
  delegate
  reflect
  engage
)

GTD_SUBCOMMANDS=(
  "${GTD_SUBCOMMANDS_FILTERLESS[@]}"
  "${GTD_SUBCOMMANDS_POSTFILTER[@]}"
)

_gtd_completions() {
  # _task
  # # local cur prev

  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  # # COMPREPLY=("$COMP_CWORD")
  # # COMPREPLY=("${COMP_WORDS[@]}")
  # COMPREPLY=("${prev}" "${cur}")

  # if [[ ${prev} == capture ]]; then
  #   COMPREPLY=(a b c)
  # fi


#   _task
  # COMPREPLY=("${GTD_SUBCOMMANDS[@]}")
  

  first_completion=false
  [[ "$COMP_CWORD" == 1 ]] && first_completion=true

  has_gtd_completion=false
  for subcommand in "${GTD_SUBCOMMANDS[@]}"; do
    if [[ " ${COMP_WORDS[*]} " =~ " ${subcommand} " ]]; then
      has_gtd_completion=true
      break
    fi
  done

  if ! $has_gtd_completion; then

    if $first_completion; then
      COMPREPLY=("${GTD_SUBCOMMANDS_FILTERLESS[@]}")
    else
      COMPREPLY=("${GTD_SUBCOMMANDS_POSTFILTER[@]}")
    fi

  fi
}

complete -F _gtd_completions gtd

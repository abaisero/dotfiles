#!/bin/bash

# check DOTFILES
: "${DOTFILES:?DOTFILES is not set}"

SOURCE="$DOTFILES/claude"
TARGET="$HOME/.claude"
rsync -av \
  "$SOURCE/CLAUDE.md" \
  "$SOURCE/settings.json" \
  "$SOURCE/commands" \
  "$SOURCE/agents" \
  "$SOURCE/skills" \
  "$SOURCE/rules" \
  "$TARGET/"

./install-claude-skills.sh

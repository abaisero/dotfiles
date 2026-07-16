#!/bin/bash

# check DOTFILES
: "${DOTFILES:?DOTFILES is not set}"

TARGET="$HOME/.claude/CLAUDE.md"
mkdir -p $(dirname "$TARGET")
ln -s --backup=numbered "$(realpath claude/CLAUDE.md)" "$TARGET"

TARGET="$HOME/.claude/settings.json"
mkdir -p $(dirname "$TARGET")
ln -s --backup=numbered "$(realpath claude/settings.json)" "$TARGET"

SOURCE="$DOTFILES/claude"
TARGET="$HOME/.claude"
rsync -av \
  "$SOURCE/commands" \
  "$SOURCE/agents" \
  "$SOURCE/skills" \
  "$SOURCE/rules" \
  "$TARGET/"

./install-claude-skills.sh
./install-claude-ccstatusline.sh

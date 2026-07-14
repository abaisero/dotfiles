#!/bin/bash
set -e

# the-fool, python-pro
REPO_DIR="$HOME/programs/claude-skills"
DEST="$HOME/.claude/skills"
SKILLS=("the-fool" "python-pro")

if [ -d "$REPO_DIR" ]; then
  git -C "$REPO_DIR" pull
else
  git clone https://github.com/Jeffallan/claude-skills.git "$REPO_DIR"
fi

mkdir -p "$HOME/.claude/skills"
for SKILL in "${SKILLS[@]}"; do
  rm -rf "$DEST/$SKILL"
  cp -r "$REPO_DIR/skills/$SKILL" "$DEST/$SKILL"
  echo "Installed $SKILL to $DEST/$SKILL"
done

# caveman
curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash

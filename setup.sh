#!/bin/bash

lnoptions="${*}"

# zshrc
ln -s "$lnoptions" "$(realpath zshrc)" "$HOME/.zshrc"

# .bash_aliases
ln -s "$lnoptions" "$(realpath bash_aliases)" "$HOME/.bash_aliases"

# tmux.conf
ln -s "$lnoptions" "$(realpath tmux.conf)" "$HOME/.tmux.conf"
ln -s "$lnoptions" "$(realpath tmux.sessions)" "$HOME/.tmux.sessions"

# vim vimrc
# ln -s "$lnoptions" $(realpath vimrc) $HOME/.vimrc

# nvim
ln -s "$lnoptions" "$(realpath nvim)" -t "$HOME/.config"

# nvim efm-langserver
mkdir -p "$HOME/.config/efm-langserver"
ln -s "$lnoptions" "$(realpath nvim.efm-langserver.config.yaml)" "$HOME/.config/efm-langserver/config.yaml"

# gitconfig
ln -s "$lnoptions" "$(realpath gitconfig)" "$HOME/.gitconfig"

# black + isort
ln -s "$lnoptions" "$(realpath black)" "$HOME/.config/black"
ln -s "$lnoptions" "$(realpath isort.cfg)" "$HOME/.isort.cfg"

# rubocop
# mkdir -p "$HOME/.config/rubocop"
# ln -s "$lnoptions" "$(realpath rubocop.yml)" "$HOME/.config/rubocop/config.yml"

# ruby gem
# ln -s "$lnoptions" "$(realpath gemrc)" "$HOME/.gemrc"

# firefox custom css
#ln -s "$lnoptions" "$(realpath firefox.userChrome.css)" "$HOME/snap/firefox/common/.mozilla/firefox/tw3f5bux.default/chrome/userChrome.css"

# alacritty
#ln -s "$lnoptions" "$(realpath alacritty.toml)" "$HOME/.config/alacritty/alacritty.toml"
#ln -s "$lnoptions" "$(realpath alacritty.yml)" "$HOME/.config/alacritty/alacritty.yml"

# zathura
# ln -s "$lnoptions" $(realpath zathurarc) "$HOME/.config/zathura/zathurarc"

# sudo apt-get install flameshot

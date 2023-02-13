#!/bin/bash

lnoptions="${@}"

# .backupfiles.conf
# ln -s $lnoptions $(realpath backupfiles.conf) $HOME/.backupfiles.conf

# bin folder
ln -s $lnoptions $(realpath bin/) $HOME/bin

# zshrc
ln -s $lnoptions $(realpath zshrc) $HOME/.zshrc

# .bash_aliases
ln -s $lnoptions $(realpath bash_aliases) $HOME/.bash_aliases

# tmux.conf
ln -s $lnoptions $(realpath tmux.conf) $HOME/.tmux.conf
ln -s $lnoptions $(realpath tmux.sessions) $HOME/.tmux.sessions

# vim vimrc
ln -s $lnoptions $(realpath vimrc) $HOME/.vimrc

# nvim init.vim
mkdir -p $HOME/.config/nvim
ln -s $lnoptions $(realpath nvim.init.vim) $HOME/.config/nvim/init.vim

# nvim efm-langserver
mkdir -p $HOME/.config/efm-langserver
ln -s $lnoptions $(realpath nvim.efm-langserver.config.yaml) $HOME/.config/efm-langserver/config.yaml

# gitconfig
ln -s $lnoptions $(realpath gitconfig) $HOME/.gitconfig

# black + isort
ln -s $lnoptions $(realpath black) $HOME/.config/black
ln -s $lnoptions $(realpath isort.cfg) $HOME/.isort.cfg

# rubocop
mkdir -p $HOME/.config/rubocop
ln -s $lnoptions $(realpath rubocop.yml) $HOME/.config/rubocop/config.yml

# ruby gem
# ln -s $lnoptions $(realpath gemrc) $HOME/.gemrc

# firefox custom css
ln -s $lnoptions $(realpath firefox.userChrome.css) $HOME/.mozilla/firefox/v1m1z198.default-1622934681939/chrome/userChrome.css

# KGS
[ -f "$HOME/bin/cgoban.jar" ] || wget -O $HOME/bin/cgoban.jar https://files.gokgs.com/javaBin/cgoban.jar

# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n

# zathura
ln -s $lnoptions $(realpath zathurarc) $HOME/.config/zathura/zathurarc

# sudo apt-get install flameshot

exit 0

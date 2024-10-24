########################
## FACILITY SHORTCUTS ##
########################

# VPN
alias vpn-beehive-up='sudo wg-quick up wg-bumblebee'
alias vpn-beehive-down='sudo wg-quick down wg-bumblebee'

# GTD alias
alias capture="task gtd-capture"

# alias swim='vim ~/notes/{pools,swimming}.vim-note -c vsplit -c bn'

alias h='history | grep'

alias tmux='tmux -2'
alias o='xdg-open'

# alias arandr='arandr --force-version'

alias mkdir='mkdir -p'
alias cp='cp -v'
alias mv='mv -v'
alias ls='ls --hyperlink=auto -hl --color=auto'
alias lt='ls --hyperlink=auto -rt'
# alias ld='ls --hyperlink=auto -l | grep \^d --color=never'
alias li='ls --hyperlink=auto -i'

alias df='\df -hT --total'
alias du='\du -xh --total'
alias files='\du -xh -all -d 1 | sort -h'
alias free='\free -m'

# easy mod for this and other files
# alias vim='nvim'
alias valiases='vim ~/.bash_aliases'
alias vtask='vim ~/.config/task/taskrc'
alias vvit='vim ~/.config/vit/config.ini'
alias vbackup='vim ~/bin/backup'
alias vbash='vim ~/.bashrc'
alias vgitconfig='vim ~/.gitconfig'
alias vpylint='vim ~/.pylintrc'
alias vssh='vim ~/.ssh/config'
alias vtmux='vim ~/.tmux.conf ~/.tmux.sessions/*.conf'
alias vvim='(cd ~/.config/nvim; vim init.lua)'
alias valacritty='vim ~/.config/alacritty/alacritty.*'
alias vzsh='vim ~/.zshrc'

alias rsync-a='rsync -avR'

# opens awesome config file
alias vawesome='vim ~/.config/awesome/rc.lua'
alias vawesome.test='vim ~/.config/awesome/test.lua'

alias init-env='python -m pip install pynvim ropevim'

# alert comand. Visualizes alert window when command ends.
# Use like so:
#   sleep 3 | alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

############################
## COMMAND LINE UTILITIES ##
############################

alias bell='paplay /usr/share/sounds/freedesktop/stereo/complete.oga'

alias gnome-control-center-reset="dconf reset -f /org/gnome/control-center/"

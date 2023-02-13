########################
## FACILITY SHORTCUTS ##
########################

alias permissions='stat -c "0%a"'

function restore_permissions() {
  for fname in $@; do
    if [ -f "$fname" ]; then
      pold=$(permissions "$fname")
      pnew=$(printf "%04d\n" "$((0666 - $(umask)))")
      echo "'$fname' (regular file).  Changing permissions $pold -> $pnew."
      chmod $pnew $fname
    elif [ -d "$fname" ]; then
      pold=$(permissions "$fname")
      pnew=$(printf "%04d\n" "$((0777 - $(umask)))")
      echo "'$fname' (folder).  Changing permissions $pold -> $pnew."
      chmod $pnew $fname
    else
      print "'$fname' (neither regular file nor folder).  Doing nothing."
    fi
  done
}

# alias swim='vim ~/notes/{pools,swimming}.vim-note -c vsplit -c bn'
# alias nb2md='jupyter nbconvert --to markdown'

alias h='history | grep'

alias tmux='tmux -2'
# easy stuff
alias o='xdg-open'
# alias u='. $HOME/.zshrc'
alias x='exit'

alias linux='lsb_release -a'
# alias latexmk='latexmk -pdf'

alias ncores='cat /proc/cpuinfo | grep processor | wc -l'
alias nusers='who | cut -f1 -d\ | sort -u | wc -l'

# alias arandr='arandr --force-version'

function note() {
  if [[ $# > 0 ]]
  then
    vim note:$1
  else
    basename -a $(find ~/notes -name '*.vim-note')
  fi
}

alias mkdir='mkdir -p'
alias cp='cp -v'
alias mv='mv -v'
alias ls='ls --hyperlink=auto -hl --color=auto'
alias lt='ls --hyperlink=auto -rt'
alias ld='ls --hyperlink=auto -l | grep \^d --color=never'
alias li='ls --hyperlink=auto -i'
alias icat='kitty +kitten icat'

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

alias df='\df -hT --total'
alias du='\du -xh --total'
alias files='\du -xh -all -d 1 | sort -h'
alias free='\free -m'

alias g='\git'

# easy mod for this and other files
alias vim='nvim'
alias valias='vim ~/.bash_aliases'
alias vbackup='vim ~/bin/backup'
alias vbash='vim ~/.bashrc'
alias vbin='vim ~/bin'
alias vgdb='vim ~/.gdbinit'
alias vgit='vim ~/.gitconfig'
alias vpylint='vim ~/.pylintrc'
alias vssh='vim ~/.ssh/config'
alias vtmux='vim ~/.tmux.conf ~/.tmux.sessions/*.conf'
alias vvim='vim ~/.config/nvim/init.vim'
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

# find commands
# function fback() {
#   fname=$1
#   folder=$PWD
#   while true; do
#     [ -e "$folder/$fname" ] && echo $folder && return 0
#     [[ "$folder" == / ]] && return 1
#     folder=$(dirname "$folder")
#   done
# }

# t commands
alias t='~/git/t/t.py --task-dir ~/taskdir'


############################
## COMMAND LINE UTILITIES ##
############################

# repeats a command a number of times
function repeat() {
  echo $#
  echo $@
  if [ $# -gt 1 ]
  then
    n=$1
    shift
    while [ n-- -ge 0 ]
    do
      "$@"
    done
  fi
}

alias bell='paplay /usr/share/sounds/freedesktop/stereo/complete.oga'

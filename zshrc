# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git git-extras tmux zsh_reload colored-man-pages colorize extract zsh-autosuggestions)
plugins=(git git-extras tmux zsh_reload colored-man-pages colorize extract z)

fpath+=$HOME/git/conda-zsh-completion

source $ZSH/oh-my-zsh.sh

compinit conda

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=vim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# BAIS - vi key bindings
bindkey -v
# BAIS - fixes certain key bindings to adhere to vim
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char
bindkey "^U" kill-line

# BAIS - search history backwards
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward

# installing texlive from source
export PATH="/usr/local/texlive/2020/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2020/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2020/texmf-dist/doc/info:$INFOPATH"

export DOTFILES="$HOME/git.new/dotfiles"

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
. $DOTFILES/completions/s-completion.sh

# needed for nvim-lsp-pyright stuff
[ -d "$HOME/node_modules/.bin" ] && export PATH="$HOME/node_modules/.bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bais/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bais/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/bais/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/bais/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# BAIS - rlpo experiments bin
[ -d "$HOME/git/rlpo/experiments/bin" ] && export PATH="$HOME/git/rlpo/experiments/bin:$PATH"

# BAIS - keychain
eval `keychain --eval --agents ssh id_rsa`

export BACKUP_DEST="nymph.proxy:backup/$(hostname)"
export DISCOVERY_SCRATCH="discovery-xfer:scratch"
export NYMPH_DISCOVERY="nymph.proxy:scratch"

export PYTHONBREAKPOINT=ipdb.set_trace

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fixing gnome-control-center issue
# from https://bugzilla.redhat.com/show_bug.cgi?id=1645664
export XDG_CURRENT_DESKTOP=GNOME

# manual golang installation
[ -d "/usr/local/go/bin" ] && export PATH="/usr/local/go/bin:$PATH"
[ -d "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"

# ruby gem path
# [ -d "$HOME/.gem/ruby/3.0.0/bin" ] && export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"

[ -f "$HOME/.private.sh" ] && source "$HOME/.private.sh"

. $HOME/bin/z.sh

if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="enabled"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

# Created by `pipx` on 2022-06-03 22:29:03
export PATH="$PATH:/home/bais/.local/bin"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

PS1="(\$(~/.rvm/bin/rvm-prompt)) $PS1"

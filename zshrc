# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  colorize
  extract
  # git
  git-extras
  git-flow
  git-flow-completion
  git-prompt
  python
  rbenv
  # ruby
  vi-mode
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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

# # vi key bindings
# bindkey -v
# # fixes certain key bindings to adhere to vim
# bindkey "^?" backward-delete-char
# bindkey "^W" backward-kill-word
# bindkey "^H" backward-delete-char
# bindkey "^U" kill-line
# # search history backwards
# bindkey "^P" history-search-backward
# bindkey "^N" history-search-forward

export DOTFILES="$HOME/git/dotfiles"
source "$DOTFILES/shell-utils"

source-if-file "$HOME/.bash_aliases"
source-if-file "$HOME/.private.sh"
export-before-path-if-dir "$HOME/bin"
source-if-file $DOTFILES/completions/*
source-if-file "$HOME/git/tmux-sessions/s-completion"

source-if-file "$HOME/programs/z/z.sh" 
source-if-file "$HOME/.fzf.zsh"

eval `keychain --eval --agents ssh id_rsa`

export-after-path-if-dir "$HOME/.local/bin"

activate-if-venv default
fpath+=${ZDOTDIR:-~}/.zsh_functions

alias luamake=/home/bais/programs/lua-language-server/3rd/luamake/luamake

# from rbenv init
eval "$(rbenv init -)"

# to use npm -g without sudo requirements
# to undo; remove the lines, and run
# npm config set prefix /usr
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export TASK_GTD_UNDERTAGGED_FILTER="(-inbox and -calendar and -someday and -waiting and -next)"
export TASK_GTD_OVERTAGGED_FILTER="(-inbox xor -someday xor -waiting xor -next)"
# export TASK_GTD_OVERTAGGED_FILTER="((+inbox and +calendar) or (+inbox and +someday) or (+inbox and +waitingfor) or (+inbox and +next) or (+calendar and +someday) or (+calendar and +waitingfor) or (+calendar and +next) or (+someday and +waitingfor) or (+someday and +next) or (+waitingfor and +next))"

autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

[ -f "/home/bais/.ghcup/env" ] && source "/home/bais/.ghcup/env" # ghcup-env

export TMUX_SESSIONS_PATH="$DOTFILES/tmux-sessions"

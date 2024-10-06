# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Rakuten stuff
export PATH=$PATH:~/build_scripts
export DOCKER_REGISTRY_DEV=rblwe01devacr.azurecr.io
export HELM_REGISTRY_DEV=rblwe01devacr
export DOCKER_REGISTRY_REL=rbljp01releaseacr.azurecr.io
export HELM_REGISTRY_REL=rbljp01releaseacr
export HELM_EXPERIMENTAL_OCI=1
export HELM_USER_DEV=
export HELM_PW_DEV=
export PATH=~/rakuten-ssh/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="/Users/pkarczewski/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
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

# export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
# eval $(/opt/homebrew/bin/brew shellenv)
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf git scala golang colored-man-pages github npm node z)

source $HOME/.oh-my-zsh/oh-my-zsh.sh
# source ~/.bash_profile

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/pkarczewski/.sdkman"
# [[ -s "/Users/pkarczewski/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/pkarczewski/.sdkman/bin/sdkman-init.sh"

############# Rakuten specific configuration ######################
#read only
# export RAKCD_BITBUCKET_TOKEN=BBDC-NzU2NTA4ODk2MjI0OjJ48zG+enU1Iw7LiAVZi3c2pEGy
# write
# export RAKCD_BITBUCKET_TOKEN=BBDC-MTA0MjgzODc5OTg2OqBhqV/Wpc4aUoSOISlLg0sp/VOX
# admin
export RAKCD_BITBUCKET_TOKEN=BBDC-NTM5MDA3NDY0NjQ5OtFI2jMhsxw7X0nhtba1AOiJs/W1
# Clone repos under the project directory. 0 or 1 Up to your preference.
export RAKCD_ORGANISE_REPO=1
export RAKCD_REPO_BASE=~/Documents/repositories/rakcd

# Enables completion. (Add only if you haven't added it.)
autoload -U compinit && compinit -i

# Change the path if you cloned the repo into different place.
source ~/rakcd/rakcd.zsh
rakcd_compinit

### BELOW ARE OPTIONAL BUT RECOMMENDED

# Let you navigate around candidates menu by tab or cursor keys.
zstyle ':completion:*:rakcd:*' menu yes select

# Start searching candidates by pressing ? or /
zmodload zsh/complist
bindkey -M menuselect '?' history-incremental-search-forward
bindkey -M menuselect '/' history-incremental-search-backward
#
########## fzf-tab configuration #####################
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
###################################################################

#TODO - fix those .dotfiles references to be to linked files
if [ -f ~/.dotfiles/scripts/z/z.sh ]; then
    . ~/.dotfiles/scripts/z/z.sh
fi
if [ -f ~/.dotfiles/scripts/.bash_scripts ]; then
    . ~/.dotfiles/scripts/.bash_scripts
fi
if [ -f ~/.dotfiles/bash_aliases/.bash_aliases ]; then
    . ~/.dotfiles/bash_aliases/.bash_aliases
fi

# export NVM_DIR="/Users/pkarczewski/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# if you cloned fzf-tab to ~/fzf-tab folder
[ -f ~/fzf-tab/fzf-tab.plugin.zsh ] && source ~/fzf-tab/fzf-tab.plugin.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

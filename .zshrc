export ZSH="/Users/nickwarwick/.oh-my-zsh"
ZSH_THEME="agnoster"

# Oh-My-Zsh Plugins
plugins=(git zsh-autosuggestions)

# Plugin customizations
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

source $ZSH/oh-my-zsh.sh

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black '%2~'
}

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

DEFAULT_USER=$(whoami)
#------

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"                           # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion" # This loads nvm bash_completion

export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# Git branch in prompt
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Aliases
alias restartaudio="sudo killall coreaudiod"
alias ll="ls -FGlAhp"
alias folder="open -a Finder ./" # Opens current directory in MacOS Finder
alias f='ls -l $(find . -type f | fzy)'
alias c="clear"
alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias gs="git status"
alias gl="git log -n 10 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gc="git checkout"
alias gbl="git branch -l"
alias gbd="git branch -d"
alias gsl="git stash list"
alias gss="git stash save -u"
alias gsp="git stash pop"
alias devdir="cd ~/Documents/dev.nosync"
alias killrails="bash ~/custom-scripts/kill-rails.sh"

export ZSH="/Users/nickwarwick/.oh-my-zsh"
ZSH_THEME="spaceship"

# Oh-My-Zsh Plugins
plugins=(
	git 
	zsh-autosuggestions
	osx
	yarn
	fzf
)

# Plugin customizations
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

source $ZSH/oh-my-zsh.sh

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

DEFAULT_USER=$(whoami)
#------

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Go stuff
export PATH=$PATH:/usr/local/go/bin

# Set default postgres DB
export PGDATABASE=postgres

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"                           # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion" # This loads nvm bash_completion

export PATH="$PATH:/usr/local/opt/yarn/1.22.5/bin"

export PATH="/usr/local/opt/postgresql@12/bin:$PATH"

export FZF_DEFAULT="/usr/local/opt/fzf"

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
alias gbnuke="git branch --merged master --no-color | grep -v master | grep -v stable | xargs git branch -d"
alias devdir="cd ~/Documents/dev.nosync"
alias killrails="pkill -f rails "
export PATH="/usr/local/sbin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

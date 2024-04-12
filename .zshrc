# Oh-My-Zsh Plugins
plugins=(
	git
	zsh-autosuggestions
	macos
	asdf
	yarn
	fzf
)

# Paths
## Path to  oh-my-zsh installation.
export ZSH="/Users/nickwarwick/.oh-my-zsh"

## FZF Setup
export FZF_BASE="/usr/local/opt/fzf/install"

## Brew Setup
export PATH="/opt/homebrew/bin:$PATH"

export PATH="/usr/local/opt/postgresql@13/bin:$PATH"

## asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

## Default text editor
export EDITOR=vim

# Aliases
alias ll="ls -FGlAhp"
alias folder="open -a Finder ./" # Opens current directory in MacOS Finder
alias c="clear"
alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias oldbrew="/usr/local/bin/brew"
## Git (lots of pre-existing aliases via oh-my-zsh)
alias gbnuke="git branch --merged main --no-color | grep -v master | grep -v stable | xargs git branch -d"
alias gcob='git branch | fzf | xargs git checkout'
alias gcom='git checkout main'
alias gdb='git branch | fzf | xargs git branch -d'
alias gDb='git branch | fzf | xargs git branch -D'

alias wdevdir="cd ~/Documents/vention-dev.nosync"
alias rdevdir="cd ~/Documents/vention-dev.nosync/vention_rails"
alias devdir="cd ~/Documents/dev.nosync"

alias killrails="pkill -f rails "

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

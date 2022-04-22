# Path to your oh-my-zsh installation.
export ZSH="/Users/nwarwick/.oh-my-zsh"

ZSH_THEME="spaceship"

# Oh-My-Zsh Plugins
plugins=(
	git
	zsh-autosuggestions
	macos
	yarn
	fzf
)

# Plugin customizations
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

export FZF_DEFAULT="/usr/local/opt/fzf"

# Paths
export PATH="/usr/local/opt/postgres:$PATH"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Default text editor
export EDITOR=vim

# Aliases
alias ll="ls -FGlAhp"
alias folder="open -a Finder ./" # Opens current directory in MacOS Finder
alias c="clear"
alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias gbnuke="git branch --merged master --no-color | grep -v master | grep -v stable | xargs git branch -d"
alias devdir="cd ~/Documents"
alias killrails="pkill -f rails "

source $ZSH/oh-my-zsh.sh



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

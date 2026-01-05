# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


plugins=(
	git
	macos
	yarn
	fzf
)

source $ZSH/oh-my-zsh.sh

# Paths

## FZF Setup
export FZF_BASE="/opt/homebrew/opt/fzf"

## Brew Setup
export PATH="/opt/homebrew/bin:$PATH"

## Local bin (for Python packages)
export PATH="$HOME/.local/bin:$PATH"

## Postgres
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Initialize mise
eval "$(mise activate zsh)"

## Default text editor
export EDITOR=nvim

## Libpq 
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Aliases
alias v="nvim"
alias cat="bat"
alias ls="eza"
alias ll="eza -lah --git"
alias folder="open -a Finder ./" # Opens current directory in MacOS Finder
alias c="clear"
alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

## Git (lots of pre-existing aliases via oh-my-zsh)
alias lg="lazygit"
alias gbnuke="git branch --merged main --no-color | grep -v master | grep -v stable | xargs git branch -d"
alias gcob='git branch | fzf | xargs git checkout'
alias gcom='git checkout main'
alias gdb='git branch | fzf | xargs git branch -d'
alias gDb='git branch | fzf | xargs git branch -D'

alias devdir="cd ~/Documents/2-Areas/dev.nosync/nodal.nosync"
alias pdevdir="cd ~/Documents/2-Areas/dev.nosync/personal.nosync"

# Notify on long-running commands (>30s)
_cmd_start_time=0
_cmd_name=""
preexec() {
  _cmd_start_time=$SECONDS
  _cmd_name="${1%% *}"
}
precmd() {
  local elapsed=$(( SECONDS - _cmd_start_time ))
  if (( elapsed > 30 && _cmd_start_time > 0 )); then
    osascript -e "display notification \"Finished in ${elapsed}s\" with title \"$_cmd_name\""
  fi
  _cmd_start_time=0
}

eval "$(starship init zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


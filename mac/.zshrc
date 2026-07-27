# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Git information
autoload -Uz vcs_info
setopt PROMPT_SUBST

zstyle ':vcs_info:git:*' formats ' %F{magenta}git:%b%f'
zstyle ':vcs_info:*' enable git

precmd() {
  vcs_info
  _sync_tmux_theme
}

# Keep an existing tmux server in sync when macOS changes appearance.
_sync_tmux_theme() {
  [[ -z "$TMUX" ]] && return

  local flavor="latte"
  [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]] &&
    flavor="frappe"

  if [[ "$(tmux show-option -gv @catppuccin_flavor 2>/dev/null)" != "$flavor" ]]; then
    tmux source-file "$HOME/.tmux.conf"
  fi
}

# Prompt: directory, Git branch, status-colored arrow
PROMPT='%F{blue}%1~%f${vcs_info_msg_0_} %(?.%F{green}.%F{red})❯%f '

# Aliases
alias n='nvim'

alias g='git'
alias gs='git status --short --branch'
alias gd='git diff'
alias gl='git log --oneline --decorate --graph -15'
alias gstu='git stash --include-untracked'
alias gco='git checkout'
alias gcom='git checkout main'
alias gcob='git branch | fzf | xargs git checkout'
alias lg="lazygit"

# Files
alias ls='eza --icons=auto --group-directories-first'
alias ll='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'

# Agentic
alias c="claude"

# Match Codex's syntax highlighting to the current macOS appearance.
codex() {
  local codex_theme="catppuccin-latte"
  [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]] &&
    codex_theme="catppuccin-frappe"

  command codex -c "tui.theme=\"$codex_theme\"" "$@"
}

alias devdir="cd ~/Documents/2-Areas/dev/nodal/"
alias pdevdir="cd ~/Documents/2-Areas/dev/personal/"
alias zdir="cd ~/Documents/2-Areas/dev/personal/zerve/"

today() {
  local note_name="$(date '+%B-%-d-%Y')"
  local note_path="$HOME/Documents/2-Areas/writing/notes/${note_name:l}.md"

  [[ -e "$note_path" ]] || printf '# %s\n\n' "$(date '+%A %B %-d, %Y')" > "$note_path"
  "$EDITOR" "$note_path"
}

# Editor
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.local/bin:$PATH"

# PostgreSQL 17 (keg-only)
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Use the 1Password SSH agent in tools that supply their own SSH config.
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# mise version manager
eval "$(mise activate zsh)"

# Vim-style command-line editing
bindkey -v
KEYTIMEOUT=1

# Search command history interactively with Ctrl+R.
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# Use a bar cursor in insert mode and a block cursor in command mode.
autoload -Uz add-zle-hook-widget

_set_vi_cursor() {
  case $KEYMAP in
    vicmd)      print -n -- $'\e[2 q' ;;
    viins|main) print -n -- $'\e[6 q' ;;
  esac
}

_reset_vi_cursor() {
  print -n -- $'\e[0 q'
}

add-zle-hook-widget keymap-select _set_vi_cursor
add-zle-hook-widget line-init _set_vi_cursor
add-zle-hook-widget line-finish _reset_vi_cursor

# History-based command suggestions (accept with Right Arrow or End)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

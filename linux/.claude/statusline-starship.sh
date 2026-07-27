#!/bin/bash
# Starship-inspired status line for Claude Code

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
session_name=$(echo "$input" | jq -r '.session_name // empty')
model_display=$(echo "$input" | jq -r '.model.display_name')
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
agent_name=$(echo "$input" | jq -r '.agent.name // empty')
output_style=$(echo "$input" | jq -r '.output_style.name // empty')

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

parts=()

# Directory (cyan, like Starship)
folder=$(basename "$cwd")
parts+=("$(printf "${CYAN}${BOLD}${folder}${RESET}")")

# Git info
if [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    cd "$cwd" 2>/dev/null || true
    branch=$(git -c core.useBuiltinFSMonitor=false branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        git_status=""
        git -c core.useBuiltinFSMonitor=false diff --quiet 2>/dev/null || git_status="*"
        git -c core.useBuiltinFSMonitor=false diff --cached --quiet 2>/dev/null || git_status="${git_status}+"
        [ -n "$(git -c core.useBuiltinFSMonitor=false ls-files --others --exclude-standard 2>/dev/null)" ] && git_status="${git_status}?"
        parts+=("$(printf "on ${MAGENTA}${BOLD}${branch}${git_status}${RESET}")")
    fi
fi

# Language versions
lang_info=""
if [ -f "$cwd/Gemfile" ] || [ -f "$cwd/.ruby-version" ]; then
    ruby_version=$(ruby -v 2>/dev/null | awk '{print $2}' | cut -d'p' -f1)
    [ -n "$ruby_version" ] && lang_info="${lang_info}$(printf "${RED}${ruby_version}${RESET}") "
fi
if [ -f "$cwd/package.json" ]; then
    node_version=$(node -v 2>/dev/null | sed 's/v//')
    [ -n "$node_version" ] && lang_info="${lang_info}$(printf "${GREEN}${node_version}${RESET}") "
fi
[ -n "$lang_info" ] && parts+=("$(printf "via ${lang_info}")")

# Session name
[ -n "$session_name" ] && parts+=("$(printf "${YELLOW}[${session_name}]${RESET}")")

# Agent name
[ -n "$agent_name" ] && parts+=("$(printf "${BLUE}agent:${agent_name}${RESET}")")

# Model (shortened)
model_short=$(echo "$model_display" | sed 's/Claude //')
parts+=("$(printf "${BLUE}${model_short}${RESET}")")

# Output style
[ -n "$output_style" ] && [ "$output_style" != "default" ] && parts+=("$(printf "${MAGENTA}${output_style}${RESET}")")

# Context usage (color-coded)
if [ -n "$context_used" ]; then
    context_int=${context_used%.*}
    if [ "$context_int" -ge 80 ]; then
        context_color="$RED"
    elif [ "$context_int" -ge 60 ]; then
        context_color="$YELLOW"
    else
        context_color="$GREEN"
    fi
    parts+=("$(printf "${context_color}${context_used}%%${RESET}")")
fi

# Vim mode
if [ -n "$vim_mode" ]; then
    if [ "$vim_mode" = "NORMAL" ]; then
        parts+=("$(printf "${GREEN}[N]${RESET}")")
    else
        parts+=("$(printf "${BLUE}[I]${RESET}")")
    fi
fi

printf "%s\n" "${parts[*]}"

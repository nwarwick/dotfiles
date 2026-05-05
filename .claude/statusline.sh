#!/usr/bin/env bash
# Claude Code statusLine. Reads session JSON on stdin, prints one line.
# Shows: model · cwd · git branch (+dirty) · ctx%.

set -u

input="$(cat)"

q() { jq -r "$1 // empty" <<< "$input" 2>/dev/null; }

model="$(q '.model.display_name')"
cwd="$(q '.workspace.current_dir')"
[[ -z "$cwd" ]] && cwd="$(q '.cwd')"
ctx_pct="$(q '.context_window.used_percentage')"

# Pretty cwd: replace $HOME with ~
display_cwd="${cwd/#$HOME/\~}"

# Git branch + dirty marker, if we're inside a repo
branch=""
if [[ -n "$cwd" && -d "$cwd" ]]; then
    if branch_name="$(git -C "$cwd" symbolic-ref --short -q HEAD 2>/dev/null)"; then
        if ! git -C "$cwd" diff --quiet --ignore-submodules HEAD 2>/dev/null; then
            branch=" $branch_name*"
        else
            branch=" $branch_name"
        fi
    fi
fi

# Format context % as integer with color tier
ctx=""
if [[ -n "$ctx_pct" ]]; then
    ctx_int="${ctx_pct%.*}"
    if (( ctx_int >= 80 )); then
        ctx=$'\e[31m'"ctx ${ctx_int}%"$'\e[0m'   # red
    elif (( ctx_int >= 50 )); then
        ctx=$'\e[33m'"ctx ${ctx_int}%"$'\e[0m'   # yellow
    else
        ctx="ctx ${ctx_int}%"
    fi
fi

# Assemble — cyan accents to match the starship.toml palette
sep=$'\e[90m│\e[0m'
parts=()
[[ -n "$model"       ]] && parts+=($'\e[36m'"$model"$'\e[0m')
[[ -n "$display_cwd" ]] && parts+=("$display_cwd")
[[ -n "$branch"      ]] && parts+=($'\e[36m'"$branch"$'\e[0m')
[[ -n "$ctx"         ]] && parts+=("$ctx")

# Join with separator
printf '%s' "${parts[0]:-}"
for ((i=1; i<${#parts[@]}; i++)); do
    printf ' %s %s' "$sep" "${parts[i]}"
done
printf '\n'

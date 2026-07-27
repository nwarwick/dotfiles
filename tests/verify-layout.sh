#!/bin/bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
    echo "FAIL: $1" >&2
    exit 1
}

for platform in mac linux; do
    [[ -d "$REPO_DIR/$platform" ]] || fail "missing $platform directory"
done

for old_path in .zshrc .mcp.json Brewfile setup-macos.sh; do
    [[ ! -e "$REPO_DIR/$old_path" ]] || fail "platform config remains at root: $old_path"
done

while IFS= read -r path; do
    [[ ! -e "$REPO_DIR/$path" ]] || fail "tracked platform config remains at root: $path"
done < <(git -C "$REPO_DIR" ls-files -- '.config/*' '.claude/*' '.local/*')

mac_files=(
    .zprofile
    .zshrc
    .gitconfig
    .tmux.conf
    Brewfile
    .config/mise/config.toml
    .config/nvim/init.lua
)

linux_files=(
    bashrc.local
    packages.txt
    .gitconfig
    .mcp.json
    .claude/settings.json
    .config/hypr/hyprland.conf
    .config/alacritty/alacritty.toml
    .local/bin/today-note
)

for path in "${mac_files[@]}"; do
    [[ -e "$REPO_DIR/mac/$path" ]] || fail "missing mac/$path"
done

for path in "${linux_files[@]}"; do
    [[ -e "$REPO_DIR/linux/$path" ]] || fail "missing linux/$path"
done

bash -n "$REPO_DIR/mac/setup-macos.sh"
bash -n "$REPO_DIR/linux/setup-linux.sh"
zsh -n "$REPO_DIR/mac/.zprofile"
zsh -n "$REPO_DIR/mac/.zshrc"

if grep -qi 'oh-my-zsh\|starship init' "$REPO_DIR/mac/.zshrc"; then
    fail "macOS shell still initializes a shell framework"
fi

echo "Layout and shell syntax checks passed"

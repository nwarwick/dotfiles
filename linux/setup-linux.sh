#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_step()    { echo -e "${GREEN}==> $1${NC}"; }
print_warning() { echo -e "${YELLOW}Warning: $1${NC}"; }
print_error()   { echo -e "${RED}Error: $1${NC}"; }

if [[ "$(uname)" != "Linux" ]]; then
    print_error "This script is for Linux. Use setup-macos.sh on macOS."
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LINUX_DIR="$DOTFILES_DIR/linux"

# Pacman packages beyond Omarchy defaults
if command -v pacman &>/dev/null; then
    print_step "Installing extra pacman packages..."
    mapfile -t pkgs < <(grep -vE '^\s*(#|$)' "$LINUX_DIR/packages.txt")
    if [[ ${#pkgs[@]} -gt 0 ]]; then
        sudo pacman -S --needed --noconfirm "${pkgs[@]}"
    fi
else
    print_warning "pacman not found; skipping package install"
fi

mkdir -p ~/.config ~/.claude

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        print_warning "Backing up existing $dest -> $dest.backup"
        mv "$dest" "$dest.backup"
    fi

    if [[ -L "$dest" ]]; then
        rm "$dest"
    fi

    ln -sf "$src" "$dest"
    echo "  Linked $dest -> $src"
}

print_step "Linking shell + Claude configs..."
backup_and_link "$LINUX_DIR/bashrc"               "$HOME/.bashrc"
backup_and_link "$DOTFILES_DIR/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
backup_and_link "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
backup_and_link "$DOTFILES_DIR/.claude/commands"  "$HOME/.claude/commands"
backup_and_link "$DOTFILES_DIR/.claude/agents"    "$HOME/.claude/agents"
backup_and_link "$DOTFILES_DIR/.mcp.json"         "$HOME/.mcp.json"

# Trust mise config directory if mise is present
if command -v mise &>/dev/null; then
    print_step "Trusting mise config..."
    mise trust "$DOTFILES_DIR" 2>/dev/null || true
fi

echo ""
print_step "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open a new shell or run: source ~/.bashrc"
echo ""
echo "Optional (these will overwrite Omarchy's defaults — opt in deliberately):"
echo "  ln -sfn $DOTFILES_DIR/.config/nvim     ~/.config/nvim"
echo "  ln -sfn $DOTFILES_DIR/.config/ghostty  ~/.config/ghostty"
echo "  ln -sf  $DOTFILES_DIR/.config/starship.toml ~/.config/starship.toml"

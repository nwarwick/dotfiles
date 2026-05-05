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

# Copy with backup. Use for files Omarchy may rewrite (themes, etc.) where
# we want our customizations as a starting point but don't want symlink
# noise in git when Omarchy edits them.
backup_and_copy() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        print_warning "Backing up existing $dest -> $dest.backup"
        mv "$dest" "$dest.backup"
    fi

    if [[ -L "$dest" ]]; then
        rm "$dest"
    fi

    cp "$src" "$dest"
    echo "  Copied $dest <- $src"
}

print_step "Wiring bashrc.local into ~/.bashrc..."
# Append-not-symlink: Omarchy migrations sed -i ~/.bashrc, so leave it
# as a plain Omarchy-owned file and just append our source line idempotently.
SOURCE_LINE='[[ -f ~/dotfiles/linux/bashrc.local ]] && source ~/dotfiles/linux/bashrc.local'
if [[ -f "$HOME/.bashrc" ]] && ! grep -qF "$SOURCE_LINE" "$HOME/.bashrc"; then
    printf '\n# Personal additions (managed in ~/dotfiles)\n%s\n' "$SOURCE_LINE" >> "$HOME/.bashrc"
    echo "  Appended source line to ~/.bashrc"
else
    echo "  ~/.bashrc already sources bashrc.local (or no ~/.bashrc found)"
fi

print_step "Linking Claude + MCP configs..."
backup_and_link "$DOTFILES_DIR/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
backup_and_link "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
backup_and_link "$DOTFILES_DIR/.claude/commands"  "$HOME/.claude/commands"
backup_and_link "$DOTFILES_DIR/.claude/agents"    "$HOME/.claude/agents"
backup_and_link "$DOTFILES_DIR/.claude/statusline.sh" "$HOME/.claude/statusline.sh"
backup_and_link "$DOTFILES_DIR/.mcp.json"         "$HOME/.mcp.json"

print_step "Linking user-owned Hyprland + Alacritty configs..."
mkdir -p "$HOME/.config/hypr" "$HOME/.config/alacritty"
backup_and_link "$DOTFILES_DIR/.config/hypr/bindings.conf" "$HOME/.config/hypr/bindings.conf"
backup_and_link "$DOTFILES_DIR/.config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
backup_and_link "$DOTFILES_DIR/.config/hypr/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
backup_and_link "$DOTFILES_DIR/.config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

# Theme-influenced files: copy as a starting point, don't symlink. Omarchy's
# theme switcher rewrites these, and we don't want those edits flowing back
# into git. Per-machine monitors.conf is intentionally excluded.
print_step "Seeding theme-adjacent configs (one-time copy)..."
mkdir -p "$HOME/.config/waybar"
backup_and_copy "$DOTFILES_DIR/.config/hypr/looknfeel.conf"  "$HOME/.config/hypr/looknfeel.conf"
backup_and_copy "$DOTFILES_DIR/.config/hypr/omambience.conf" "$HOME/.config/hypr/omambience.conf"
backup_and_copy "$DOTFILES_DIR/.config/waybar/config.jsonc"  "$HOME/.config/waybar/config.jsonc"
backup_and_copy "$DOTFILES_DIR/.config/waybar/style.css"     "$HOME/.config/waybar/style.css"

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

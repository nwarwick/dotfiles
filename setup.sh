#!/bin/bash

set -e

echo "==> Setting up macOS development environment"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${GREEN}==> $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}Warning: $1${NC}"
}

print_error() {
    echo -e "${RED}Error: $1${NC}"
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    print_error "This script is intended for macOS only"
    exit 1
fi

# Install Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
    print_step "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Please complete the Xcode installation and re-run this script."
    exit 0
fi

# Install Homebrew
if ! command -v brew &>/dev/null; then
    print_step "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    print_step "Homebrew already installed"
fi

# Install Homebrew packages
print_step "Installing Homebrew packages..."
brew install \
    neovim \
    fzf \
    mise \
    starship \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    ripgrep \
    fd \
    bat \
    eza \
    lazygit \
    postgresql@16 \
    libpq

# Install Nerd Font
print_step "Installing JetBrainsMono Nerd Font..."
brew install --cask font-jetbrains-mono-nerd-font

# Install Ghostty
print_step "Installing Ghostty terminal..."
brew install --cask ghostty

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    print_step "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_step "Oh My Zsh already installed"
fi

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create config directories if they don't exist
mkdir -p ~/.config
mkdir -p ~/.claude

# Create symlinks
print_step "Creating symlinks..."

# Backup existing files if they exist and aren't symlinks
backup_and_link() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        print_warning "Backing up existing $dest to $dest.backup"
        mv "$dest" "$dest.backup"
    fi

    if [[ -L "$dest" ]]; then
        rm "$dest"
    fi

    ln -sf "$src" "$dest"
    echo "  Linked $dest -> $src"
}

backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
backup_and_link "$DOTFILES_DIR/.config/ghostty" "$HOME/.config/ghostty"
backup_and_link "$DOTFILES_DIR/.config/aerospace" "$HOME/.config/aerospace"
backup_and_link "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
backup_and_link "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
backup_and_link "$DOTFILES_DIR/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

# Setup fzf key bindings
print_step "Setting up fzf..."
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

# Trust mise config directory
print_step "Setting up mise..."
mise trust "$DOTFILES_DIR" 2>/dev/null || true

echo ""
print_step "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Neovim to install plugins: nvim"
echo "     (LazyVim will automatically install plugins on first launch)"
echo "  3. In Neovim, run :checkhealth to verify setup"
echo ""
echo "Optional:"
echo "  - Install language versions with mise:"
echo "      mise use node@lts"
echo "      mise use ruby@latest"
echo "      mise use python@latest"

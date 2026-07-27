#!/bin/bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_step()    { echo -e "${GREEN}==> $1${NC}"; }
print_warning() { echo -e "${YELLOW}Warning: $1${NC}"; }
print_error()   { echo -e "${RED}Error: $1${NC}"; }

if [[ "$(uname)" != "Darwin" ]]; then
    print_error "This script is for macOS. Use linux/setup-linux.sh on Linux."
    exit 1
fi

MAC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! xcode-select -p &>/dev/null; then
    print_step "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Complete the Xcode installation, then run this script again."
    exit 0
fi

if ! command -v brew &>/dev/null; then
    print_step "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    print_step "Homebrew already installed"
fi

print_step "Installing Homebrew packages..."
brew bundle --file="$MAC_DIR/Brewfile"

mkdir -p "$HOME/.config" "$HOME/.config/mise"

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        local backup="$dest.backup.$(date +%Y%m%d%H%M%S)"
        print_warning "Backing up existing $dest -> $backup"
        mv "$dest" "$backup"
    fi

    if [[ -L "$dest" ]]; then
        rm "$dest"
    fi

    ln -s "$src" "$dest"
    echo "  Linked $dest -> $src"
}

print_step "Creating symlinks..."
backup_and_link "$MAC_DIR/.zprofile" "$HOME/.zprofile"
backup_and_link "$MAC_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$MAC_DIR/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$MAC_DIR/.tmux.conf" "$HOME/.tmux.conf"
backup_and_link "$MAC_DIR/.config/nvim" "$HOME/.config/nvim"
backup_and_link "$MAC_DIR/.config/mise/config.toml" "$HOME/.config/mise/config.toml"

install_tmux_plugin() {
    local repo="$1"
    local revision="$2"
    local dest="$3"

    if [[ -d "$dest/.git" ]]; then
        echo "  tmux plugin already installed: $dest"
        return
    fi

    git clone --quiet "$repo" "$dest"
    git -C "$dest" checkout --quiet "$revision"
    echo "  Installed tmux plugin: $dest"
}

print_step "Installing tmux plugins..."
mkdir -p "$HOME/.config/tmux/plugins/tmux-plugins"
install_tmux_plugin \
    "https://github.com/christoomey/vim-tmux-navigator.git" \
    "e41c431a0c7b7388ae7ba341f01a0d217eb3a432" \
    "$HOME/.config/tmux/plugins/vim-tmux-navigator"
install_tmux_plugin \
    "https://github.com/tmux-plugins/tmux-yank.git" \
    "acfd36e4fcba99f8310a7dfb432111c242fe7392" \
    "$HOME/.config/tmux/plugins/tmux-plugins/tmux-yank"

echo ""
print_step "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open a new terminal or run: source ~/.zshrc"
echo "  2. Create ~/.gitconfig.local from $MAC_DIR/.gitconfig.local.example"
echo "  3. Open Neovim once to install plugins"

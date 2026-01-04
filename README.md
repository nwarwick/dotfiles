# Dotfiles

Personal dotfiles for macOS development environment.

## Quick Start

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The setup script will install all dependencies and create symlinks automatically.

## What's Included

| Config | Description |
|--------|-------------|
| `.zshrc` | Zsh with Oh My Zsh, Starship prompt, and custom aliases |
| `.config/nvim/` | Neovim with LazyVim |
| `.config/ghostty/` | Ghostty terminal |

## Manual Installation

If you prefer to install manually:

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install packages

```bash
brew install neovim fzf asdf starship zsh-autosuggestions ripgrep fd lazygit postgresql@16 libpq
brew install --cask font-jetbrains-mono-nerd-font ghostty
```

### 3. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 4. Create symlinks

```bash
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/dotfiles/.config/ghostty ~/.config/ghostty
```

### 5. Setup Neovim

LazyVim and all plugins install automatically on first launch:

```bash
nvim
```

Wait for plugins to install, then run `:checkhealth` to verify everything is working.

## Shell

**Framework**: Oh My Zsh
**Prompt**: Starship
**Plugins**: git, macos, yarn, fzf

### Key Aliases

| Alias | Command |
|-------|---------|
| `v` | `nvim` |
| `ll` | `ls -FGlAhp` |
| `gcob` | Interactive branch checkout with fzf |
| `gcom` | `git checkout main` |
| `gbnuke` | Delete merged branches |

## Neovim

Built on [LazyVim](https://www.lazyvim.org/) with these extras enabled:

- **Languages**: TypeScript, JSON, Ruby
- **Formatting**: Prettier
- **Linting**: ESLint
- **Tools**: lazygit integration

### First Launch

1. Open Neovim: `nvim`
2. Plugins auto-install via lazy.nvim
3. Run `:checkhealth` to verify setup
4. Press `Space` to see available keybindings

## Ghostty

- **Font**: JetBrainsMono Nerd Font, 14pt
- **Shell integration**: zsh

## Version Management

Uses [asdf](https://asdf-vm.com/) for managing runtime versions. The setup script installs plugins for Node.js, Ruby, and Python.

```bash
# Install a version
asdf install nodejs latest
asdf global nodejs latest

# List installed versions
asdf list
```

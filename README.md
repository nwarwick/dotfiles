# Dotfiles

Personal dotfiles. Primary target is macOS; Omarchy (Arch + Hyprland) is
supported as a secondary target for the cross-platform configs.

## Quick Start

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./setup-macos.sh         # macOS
./linux/setup-linux.sh   # Omarchy / Arch
```

The setup script will install dependencies and create symlinks automatically.
See [`linux/README.md`](linux/README.md) for what the Linux variant does and
doesn't symlink (Omarchy ships its own nvim/ghostty/starship configs).

## What's Included

| Config | Description | Platform |
|--------|-------------|----------|
| `.zshrc` | Zsh with Oh My Zsh, Starship prompt, and custom aliases | macOS |
| `.config/nvim/` | Neovim with LazyVim | both |
| `.config/ghostty/` | Ghostty terminal | both |
| `.config/aerospace/` | AeroSpace tiling window manager | macOS |
| `.config/starship.toml` | Starship prompt overrides | both |
| `.claude/` | Claude Code settings and global instructions | both |
| `.mcp.json` | MCP server config (`fetch`) | both |
| `linux/bashrc` | Bash config that layers on Omarchy's defaults | Linux |
| `Brewfile` | macOS package list | macOS |
| `linux/packages.txt` | pacman package list (extras beyond Omarchy) | Linux |

## Manual Installation

If you prefer to install manually:

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install packages

```bash
brew install neovim fzf mise starship zsh-autosuggestions ripgrep fd lazygit postgresql@16 libpq
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
ln -sf ~/dotfiles/.config/aerospace ~/.config/aerospace
ln -sf ~/dotfiles/.claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/.claude/CLAUDE.md ~/.claude/CLAUDE.md
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

## AeroSpace

Tiling window manager for macOS. Key bindings use Alt as the main modifier.

- **Workspaces**: 1-9 bound to Alt+number
- **Focus**: Alt+H/J/K/L for vim-style navigation
- **Move windows**: Alt+Shift+H/J/K/L
- **Layouts**: Alt+/ for tiles, Alt+, for accordion

## Claude Code

Global settings for [Claude Code](https://claude.ai/code):

- **Attribution disabled**: No AI references in commits or PRs
- **CLAUDE.md**: Global instructions applied to all projects

## Version Management

Uses [mise](https://mise.jdx.dev/) for managing runtime versions (node, ruby, python, etc.).

```bash
# Install and activate a version
mise use node@lts
mise use ruby@latest
mise use python@latest

# List installed versions
mise list

# Install all versions from .mise.toml
mise install
```

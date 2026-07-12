# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environment configuration. It contains configuration files that are symlinked to `~/.config/` and `~/` during setup.

## Setup

```bash
./setup.sh           # Full automated setup (Homebrew, packages, symlinks)
source ~/.zshrc      # Reload shell after setup
```

## Structure

| Path | Purpose |
|------|---------|
| `.zshrc` | Zsh config with Oh My Zsh, Starship prompt, and aliases |
| `.config/nvim/` | LazyVim-based Neovim configuration |
| `.config/ghostty/` | Ghostty terminal config |
| `.Codex/` | Codex settings (symlinked to `~/.Codex/`) |
| `setup.sh` | Automated installation script |

## Neovim Configuration

- Based on [LazyVim](https://lazyvim.org/)
- Plugins managed via lazy.nvim (`lua/config/lazy.lua`)
- Custom plugins go in `lua/plugins/*.lua`
- Current colorscheme: gruvbox

To add/modify plugins, edit files in `.config/nvim/lua/plugins/`. LazyVim conventions apply:
- Return a table of plugin specs
- Use `opts` to configure plugins
- Use `{ import = "lazyvim.plugins.extras.X" }` for LazyVim extras

## Key Conventions

- Shell aliases use short forms (`v` for nvim, `ll` for detailed ls)
- Git aliases prefer `fzf` for interactive selection (`gcob`, `gdb`)
- Symlinks are created from this repo to home directory locations

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles. Primary target is macOS; Omarchy (Arch + Hyprland) is
a secondary target for the cross-platform configs. Files are symlinked to
`~/.config/` and `~/` during setup.

## Setup

```bash
./setup-macos.sh         # macOS: Homebrew, packages, symlinks
./linux/setup-linux.sh   # Omarchy/Arch: pacman extras + safe symlinks only
```

## Structure

| Path | Purpose |
|------|---------|
| `.zshrc` | Zsh config (macOS) with Oh My Zsh, Starship, aliases |
| `.config/nvim/` | LazyVim-based Neovim configuration |
| `.config/ghostty/` | Ghostty terminal config |
| `.config/aerospace/` | AeroSpace tiling window manager (macOS) |
| `.claude/` | Claude Code settings (symlinked to `~/.claude/`) |
| `.mcp.json` | MCP server config |
| `setup-macos.sh` | macOS installer |
| `linux/` | Omarchy/Arch installer + bashrc + extra packages |

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
- AeroSpace uses Alt as the main modifier key
- Symlinks are created from this repo to home directory locations

## Linux / Omarchy notes

- `linux/setup-linux.sh` (a) appends an idempotent `source` line to
  `~/.bashrc` for `linux/bashrc.local`, and (b) symlinks `.claude/` +
  `.mcp.json`. It deliberately avoids overriding Omarchy's nvim,
  ghostty, and starship configs — the script prints opt-in commands at
  the end.
- `~/.bashrc` is intentionally **not** symlinked: Omarchy migrations
  `sed -i` it in place. Personal additions live in `linux/bashrc.local`,
  which `~/.bashrc` sources at the bottom.
- `linux/bashrc.local` runs *after* Omarchy's bash defaults, so it
  shouldn't re-source them or add an interactive-shell guard.
- Most Brewfile packages are already in Omarchy; `linux/packages.txt`
  only lists the gaps.

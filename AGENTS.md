# AGENTS.md

This file provides guidance to Codex when working in this repository.

## Repository overview

Personal dotfiles with fully isolated macOS and Omarchy / Arch Linux trees.
Do not introduce dependencies between `mac/` and `linux/`; a platform setup
must continue to work using only files beneath its own directory.

## Setup

```bash
./mac/setup-macos.sh     # macOS: Homebrew, packages, symlinks, tmux plugins
./linux/setup-linux.sh   # Omarchy/Arch: pacman extras + safe symlinks/copies
```

## Structure

| Path | Purpose |
|---|---|
| `mac/` | Plain Zsh, tmux, Git, mise, LazyVim, and Homebrew baseline |
| `linux/` | Preserved Omarchy shell, desktop, agent, and optional app configs |
| `mac/setup-macos.sh` | macOS installer |
| `linux/setup-linux.sh` | Linux installer |

## macOS notes

- The shell uses native Zsh completion and `vcs_info`; do not add Oh My Zsh or
  Starship without an explicit request.
- `mac/.zshrc`, `mac/.tmux.conf`, and `mac/.config/nvim/` reflect the baseline
  Mac's active configuration.
- Ghostty currently uses its defaults and AeroSpace is not part of the macOS
  baseline.
- Machine-local Git identity and credentials stay in `~/.gitconfig.local`.

## Neovim configuration

Both platforms have independent LazyVim trees. Custom plugin specs belong in
the relevant platform's `.config/nvim/lua/plugins/` directory. Follow LazyVim
plugin-spec conventions and do not copy a change across platforms implicitly.

## Linux / Omarchy notes

- `linux/setup-linux.sh` appends an idempotent source line for
  `linux/bashrc.local` to `~/.bashrc`.
- `~/.bashrc` is intentionally not symlinked because Omarchy migrations edit it
  in place.
- Theme-influenced Hyprland and Waybar files are copied; user-owned configs are
  symlinked.
- Omarchy's Neovim, Ghostty, and Starship configs are preserved by default;
  Linux-owned alternatives are opt-in.

# Dotfiles

Personal dotfiles for macOS development environment.

## Contents

- **`.zshrc`** - Zsh configuration with Oh My Zsh, Starship prompt, and custom aliases
- **`.config/nvim/`** - Neovim configuration based on LazyVim
- **`.config/ghostty/`** - Ghostty terminal configuration

## Dependencies

Install via Homebrew:

```bash
brew install neovim fzf asdf starship zsh-autosuggestions postgresql@16
```

Additional requirements:
- [Oh My Zsh](https://ohmyz.sh/)
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)

## Installation

Clone the repository and symlink the files:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Zsh
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# Neovim
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

# Ghostty
ln -sf ~/dotfiles/.config/ghostty ~/.config/ghostty
```

## Highlights

### Shell

- **Plugins**: git, macos, yarn, fzf
- **Prompt**: Starship
- **Version manager**: asdf

### Key Aliases

| Alias | Command |
|-------|---------|
| `v` | `nvim` |
| `ll` | `ls -FGlAhp` |
| `gcob` | Interactive branch checkout with fzf |
| `gcom` | `git checkout main` |

### Neovim

LazyVim starter configuration. See `.config/nvim/` for customizations.

### Ghostty

JetBrainsMono Nerd Font, 14pt, with shell integration.

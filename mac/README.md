# macOS setup

This directory is a self-contained snapshot of the active development setup on
the baseline Mac. It deliberately uses plain Zsh with native completion and
`vcs_info`; it does not install Oh My Zsh or Starship.

## Install

```bash
./mac/setup-macos.sh
```

The installer:

1. Installs Xcode Command Line Tools and Homebrew when needed.
2. Installs the packages in `mac/Brewfile`.
3. Backs up existing targets and symlinks the tracked Zsh, Git, tmux, Neovim,
   and mise configuration.
4. Installs the pinned tmux navigator and clipboard plugins.

## Managed files

| Source | Target |
|---|---|
| `mac/.zprofile` | `~/.zprofile` |
| `mac/.zshrc` | `~/.zshrc` |
| `mac/.gitconfig` | `~/.gitconfig` |
| `mac/.tmux.conf` | `~/.tmux.conf` |
| `mac/.config/nvim` | `~/.config/nvim` |
| `mac/.config/mise/config.toml` | `~/.config/mise/config.toml` |

Machine-local Git identity and credential helpers belong in
`~/.gitconfig.local`. Start from `mac/.gitconfig.local.example`; never commit
the completed local file.

Ghostty is installed separately on the baseline Mac and currently uses its
defaults, so there is no tracked Ghostty configuration. Agent tooling is also
outside the macOS baseline and remains machine-local.

# Linux setup (Omarchy)

Linux-side complement to the macOS dotfiles. Targets [Omarchy](https://omarchy.org)
(Arch + Hyprland), but the bashrc/setup script work on any Arch-based distro
that has the same Omarchy bash defaults at `~/.local/share/omarchy/`.

## What gets symlinked

`./setup-linux.sh` only links the configs that don't conflict with
Omarchy's curated defaults:

| Source | Target |
|---|---|
| `linux/bashrc` | `~/.bashrc` |
| `.claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `.claude/settings.json` | `~/.claude/settings.json` |
| `.claude/commands` | `~/.claude/commands` |
| `.claude/agents` | `~/.claude/agents` |
| `.mcp.json` | `~/.mcp.json` |

Existing files are backed up to `*.backup` before linking.

## What is NOT symlinked (intentional)

Omarchy ships its own opinionated configs for these — replacing them
will lose Omarchy's tuning. The setup script prints opt-in commands at
the end if you want to override:

- `.config/nvim` — Omarchy's LazyVim with `neo-tree`. The dotfiles
  version adds TypeScript / JSON / Ruby / Prettier / ESLint extras.
- `.config/ghostty` — Omarchy's config wires in theme switching,
  Hyprland fixes, and SSH integration. The dotfiles version is minimal.
- `.config/starship.toml` — Omarchy's prompt is fully styled. The
  dotfiles version only bumps `command_timeout`.

## Shell

`linux/bashrc` sources Omarchy's default bash rc first, then adds
personal aliases. Notable overrides vs Omarchy:

- `c` → `clear` (Omarchy aliases `c` to `opencode`; opencode still on PATH)
- `cat` → `bat`

`devdir` / `pdevdir` point at `~/Documents/2-Areas/dev/{nodal,personal}`
(no `.nosync` suffix since iCloud isn't in play).

## Packages

`linux/packages.txt` lists pacman packages beyond Omarchy's defaults
(currently just `uv` for Python tooling). The Brewfile equivalents
— neovim, fzf, mise, starship, ripgrep, fd, bat, eza, lazygit,
ghostty, JetBrains Mono Nerd Font — are already part of Omarchy.

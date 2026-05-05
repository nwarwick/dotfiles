# Linux setup (Omarchy)

Linux-side complement to the macOS dotfiles. Targets [Omarchy](https://omarchy.org)
(Arch + Hyprland), but the bashrc/setup script work on any Arch-based distro
that has the same Omarchy bash defaults at `~/.local/share/omarchy/`.

## What gets wired up

`./setup-linux.sh` does three things:

1. Appends a single source line to `~/.bashrc` (idempotent) so Omarchy
   keeps owning that file. See "Why not symlink ~/.bashrc" below.
2. **Symlinks** files we own (edits flow through git on either machine):

| Source | Target |
|---|---|
| `linux/bashrc.local` | sourced from `~/.bashrc` (not symlinked) |
| `.claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `.claude/settings.json` | `~/.claude/settings.json` |
| `.claude/commands` | `~/.claude/commands` |
| `.claude/agents` | `~/.claude/agents` |
| `.claude/statusline.sh` | `~/.claude/statusline.sh` |
| `.mcp.json` | `~/.mcp.json` |
| `.config/hypr/bindings.conf` | `~/.config/hypr/bindings.conf` |
| `.config/hypr/hyprland.conf` | `~/.config/hypr/hyprland.conf` |
| `.config/hypr/hypridle.conf` | `~/.config/hypr/hypridle.conf` |
| `.config/alacritty/alacritty.toml` | `~/.config/alacritty/alacritty.toml` |

3. **Copies** (not symlinks) theme-influenced files. Omarchy's theme
   switcher rewrites these, and we don't want those edits flowing back
   into git. Treat the dotfiles versions as a starting point:

| Source | Target |
|---|---|
| `.config/hypr/looknfeel.conf` | `~/.config/hypr/looknfeel.conf` |
| `.config/hypr/omambience.conf` | `~/.config/hypr/omambience.conf` |
| `.config/waybar/config.jsonc` | `~/.config/waybar/config.jsonc` |
| `.config/waybar/style.css` | `~/.config/waybar/style.css` |

Existing files are backed up to `*.backup` before linking or copying.

`monitors.conf` is intentionally **not** tracked — it's per-machine.

### Why not symlink ~/.bashrc

Omarchy ships migrations under `~/.local/share/omarchy/migrations/` that
mutate `~/.bashrc` in place via `sed -i` (e.g., to ensure the interactive
guard line is present). If `~/.bashrc` were a symlink into this repo,
those migrations would silently rewrite the tracked file. We keep
`~/.bashrc` as Omarchy's plain file and append one source line that
pulls in `linux/bashrc.local`.

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

`linux/bashrc.local` is sourced *after* Omarchy's defaults, so its
aliases/functions only override when they intentionally redefine a name.
Current additions:

- `ll` — `eza -lah --git --icons=auto` (matches Omarchy's icon styling)
- `bcat` — `bat` (no `cat` alias; Omarchy's stance is to keep `cat`
  as plain `cat` and use `bat` explicitly)
- `lg` — `lazygit`
- `myip` — first non-loopback IPv4
- `gcom` / `gcob` / `gdb` / `gDb` / `gbnuke` — branch helpers,
  default-branch-aware (work in `main`/`master`/`develop` repos via
  `git rev-parse origin/HEAD`)
- `devdir` / `pdevdir` — jump to `~/Documents/2-Areas/dev/{nodal,personal}`
  (no `.nosync` suffix since iCloud isn't in play)

Things deliberately *not* aliased here: `v` (use Omarchy's `n` function,
which does `nvim .` with no args), `c` (Omarchy uses it for `opencode`;
`Ctrl+L` clears the screen anyway), and `EDITOR` (already exported by
`~/.config/uwsm/default`).

Secrets / per-machine overrides go directly in `~/.bashrc` — that file
is no longer symlinked, so private edits stay off git naturally.

## Packages

`linux/packages.txt` lists pacman packages beyond Omarchy's defaults
(currently just `uv` for Python tooling). The Brewfile equivalents
— neovim, fzf, mise, starship, ripgrep, fd, bat, eza, lazygit,
ghostty, JetBrains Mono Nerd Font — are already part of Omarchy.

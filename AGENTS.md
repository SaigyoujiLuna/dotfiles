# AGENTS.md

Agent context for the `dotfiles` repository.

## What this repo is

Personal dotfiles for Yuki, managed with **GNU Stow**. No build system, no test suite, no CI.

---

## Deploy

```bash
./deploy.sh          # requires `stow` on $PATH
```

- Auto-detects OS (`uname`): stows `common unix macos` on Darwin, `common unix linux` on Linux.
- Uses `stow --dotfiles --adopt`: **`--adopt` pulls existing `$HOME` files into the repo**, potentially overwriting tracked files with local versions. Do not run blindly on a machine with diverged local configs.
- After stowing, copies `./private_passport.conf` → `~/.config/private_passport.conf`.

---

## Directory layout

| Directory | Deployed on |
|-----------|-------------|
| `common/` | all platforms |
| `unix/`   | macOS + Linux |
| `macos/`  | macOS only |
| `linux/`  | Linux only |

**Stow `dot-` convention:** `dot-foo` → `.foo`, `dot-config/` → `.config/`.

---

## Secrets / private config

- `./private_passport.conf` and `common/dot-config/private_passport.conf` are **empty templates** in the repo.
- The Linux zshrc sources `~/.config/private_passport.conf` as environment variables (`set -a; source ...; set +a`).
- Never commit real values. The file is not gitignored by name — only `.DS_Store` is in `.gitignore`.

---

## Neovim config (`unix/dot-config/nvim/`)

- **Plugin manager:** `zpack.nvim` (wraps `vim.pack`). Commands prefixed `Z`. **Not lazy.nvim** — a `lazy-lock.json` exists but is gitignored and unused; the active lock file is `nvim-pack-lock.json`.
- **Global namespace:** `_G.YukiVim = require("utils")` — used throughout as `YukiVim.lsp`, `YukiVim.cmp`, `YukiVim.config`, `YukiVim.treesitter`.
- **Rust LSP:** `rust_analyzer` is explicitly **disabled**. `bacon-ls` handles diagnostics; `rustaceanvim` handles the rest.
- **Lua style** (`.stylua.toml`): 2-space indent, 120-column width, Unix line endings, `AutoPreferDouble` quotes.

---

## OpenSpec workflow

Structured AI change management lives in `openspec/`. Use the opencode slash commands:

| Command | Purpose |
|---------|---------|
| `/opsx-propose` | Draft a new change (proposal + design + tasks) |
| `/opsx-apply`   | Implement tasks from an open change |
| `/opsx-explore` | Explore/investigate — read only, no writes |
| `/opsx-archive` | Archive a completed change |

Changes live in `openspec/changes/<name>/`. Archived changes move to `openspec/changes/archive/YYYY-MM-DD-<name>/`. Requires the `openspec` CLI binary.

---

## Non-obvious quirks

- **No validation step.** There is no `make check`, lint, or test command at the repo root. Manual verification means running `deploy.sh` on a target machine.
- **`dot-picgo/`** contains only a `.gitignore` — actual PicGo config (likely API keys) is excluded.
- **`YukiConfig.code-profile`** is stow-ignored; it is not symlinked.
- **`~/.local/bin/disown_run.sh`** is a two-line helper that fully detaches a process: used by the `neovide` shell alias on Linux.
- **Powerlevel10k and Starship are both configured.** `dot-p10k.zsh` is a full p10k config; `zsh-starship` is also in the antidote plugin list. The Linux zshrc sources `~/.p10k.zsh` at the end — only one prompt will actually be active at runtime.
- **CJK locale split on Linux:** `LANG=zh_CN.UTF-8` but `LC_MESSAGES=en_US.UTF-8` — CLI messages appear in English despite the Chinese system locale.

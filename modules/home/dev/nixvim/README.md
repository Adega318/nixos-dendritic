# Nixvim Configuration

A comprehensive, modular Neovim configuration built with [Nixvim](https://github.com/nix-community/nixvim). Prioritizes speed, developer ergonomics, and a polished UI. Enabled as `flake.modules.homeManager.nixvim` (re-exported via the `dev` aggregator) with `home.sessionVariables.EDITOR = "nvim"`.

## Features

- **Language Server Protocol (LSP)** — 16+ servers: `bashls`, `clangd`, `nixd`/`statix`, `lua_ls`, `pyright`/`ruff`, `taplo`, `yamlls`, `sqls`, `marksman`, `jdtls`, `lemminx`, `tflint`, `elixirls`, `gleam`, `gopls`, `kotlin_language_server`, `prolog_ls`; Rust via `rustaceanvim` + `crates.nvim` — see `lsp/` and `lsp/rust/`.
- **Formatting & Linting** — `conform.nvim` (format on `<leader>fm`) and `nvim-lint`.
- **Diagnostics UI** — `trouble.nvim` (`<leader>d`) + `fidget.nvim` progress.
- **Modern UI** — `noice.nvim` (cmdline), `lualine`, `bufferline`, `which-key`, `render-markdown`.
- **Git** — `gitsigns` (hunks, blame, diff) + `lazygit` (`<leader>gl`), Telescope git pickers.
- **Smart Search** — `telescope.nvim` + `fzf-native`, `frecency`, `undo`, `ui-select` extensions.
- **Treesitter** — `nvim-treesitter` (highlight + indent) + `treesitter-context` (sticky headers, `max_lines = 2`) + `rainbow-delimiters`.
- **Productivity** — `nvim-autopairs`, `nvim-surround`, `Comment.nvim`, `nvim-tree`, `toggleterm`, `autosave.nvim`, `todo-comments.nvim`, `indent-blankline.nvim`, `bufdelete.nvim`, `snacks.nvim` (terminal/input/picker).
- **Opencode integration** — `opencode.nvim` + `snacks.terminal` (`opencode --port` on the right) — see `utils/opencode.nix`.
- **Completion** — `nvim-cmp` + `luasnip` + `friendly-snippets` (buffer, emoji, path, LSP sources, ghost text, bordered windows).

## Configuration Structure

```
modules/home/dev/nixvim/
├── default.nix          # Imports nixvim HM module, sets EDITOR, opts (updatetime 100, line numbers, splits, tabs=2, smartcase, undofile, termguicolors, prolog filetype)
├── keymaps.nix          # General window/buffer/tab/centered movement keymaps
├── cmp.nix              # nvim-cmp + luasnip + friendly-snippets (ghost_text, bordered windows, <C-n>/<C-p>/<Tab> mappings)
├── pkgs.nix             # Extra packages: cargo/rustc/rustfmt, go, nil/nixd, ripgrep
├── lsp/                 # LSP + formatting/linting/diagnostics
│   ├── default.nix      # lsp.servers + keymaps (gd/gr/gD/gI/gT/K/<leader>cr/ca/cw/fm/cl, [d/]d/<leader>cd)
│   ├── conform.nix      # Formatter config
│   ├── lint.nix         # Linter config
│   ├── trouble.nix      # Diagnostics list
│   ├── fidget.nix       # LSP progress
│   ├── ionide.nix       # F# (Ionide)
│   └── rust/
│       ├── rustaceanvim.nix
│       └── crates.nix
├── ui/                  # Appearance
│   ├── lualine.nix
│   ├── bufferline.nix
│   ├── noice.nix
│   ├── which-key.nix
│   ├── treesitter.nix   # treesitter + treesitter-context + rainbow-delimiters; <leader>co
│   └── markdown.nix     # render-markdown
└── utils/               # Productivity plugins
    ├── telescope.nix    # telescope + fzf-native/frecency/undo/ui-select; <leader><space> ff / fg / gc … (see cheatsheet)
    ├── git.nix          # gitsigns + lazygit; ]h/[h, <leader>gl/gd/gs/gS/gu/gtb/gtd/grh/grb
    ├── opencode.nix     # opencode + snacks.terminal; <C-a>/<C-x>/<C-.>/go/goo/+ /-
    ├── nvim-tree.nix    # File tree; <C-n>/<leader>n
    ├── toggleterm.nix   # Terminal; <C-t>
    ├── comment.nix      # gcc/gc
    ├── surround.nix     # ys/cs/ds
    ├── auto-pairs.nix
    ├── autosave.nix
    ├── blankline.nix
    ├── bufdelete.nix    # <leader>bd/bw
    └── todo-comments.nix# <leader>st via Telescope
```

## Keymap Cheatsheet

> **Leader**: `<Space>`

### Window Navigation & Resizing

| Key | Mode | Action |
|-----|------|--------|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | n, t | Move to Left / Down / Up / Right window (`<C-w>h/j/k/l`) |
| `<C-Up>` / `<C-Down>` | n | Resize height +2 / -2 |
| `<C-Left>` / `<C-Right>` | n | Resize width -2 / +2 |

### Buffers & Tabs

| Key | Mode | Action |
|-----|------|--------|
| `<S-h>` / `<S-l>` | n | Previous / Next buffer (bufferline) |
| `<leader>bn` | n | Previous buffer |
| `<leader>bb` | n | Switch to last buffer |
| `<leader>bd` | n | Delete current buffer (`bufdelete`) |
| `<leader>bw` | n | Wipe current buffer |
| `<leader>tn` / `<leader>td` | n | New tab / Close tab |
| `<leader>th` / `<leader>tl` | n | Previous / Next tab |
| `<C-n>` / `<leader>n` | n | Toggle file tree (NvimTree) |

### Editing & Movement

| Key | Mode | Action |
|-----|------|--------|
| `<C-d>` / `<C-u>` | n | Scroll half-page Down / Up (cursor centered `zz`) |
| `n` / `N` | n | Next / Prev search result (centered `zzzv`) |
| `J` / `K` | v | Move selected block Down / Up (`:m '>+1` / `'<-2`) |
| `<esc>` | n | Clear search highlights (`:nohlsearch`) |
| `<C-s>` | n | Save (`:w`) |
| `<leader>q` | n | Quit (`:q`) |
| `<leader>Q` | n | Quit all (`:qa`) |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to Definition |
| `gD` | n | Declaration |
| `gr` | n | References |
| `gI` | n | Implementation |
| `gT` | n | Type Definition |
| `K` / `gK` | n | Hover / Signature help |
| `<leader>cr` | n | Rename symbol |
| `<leader>ca` | n | Code Action |
| `<leader>cw` | n | Workspace symbol |
| `<leader>fm` | n | Format buffer (`conform`, async + lsp_fallback) |
| `<leader>cl` | n | Restart LSP (`:LspRestart`) |

### Diagnostics

| Key | Mode | Action |
|-----|------|--------|
| `[d` / `]d` | n | Previous / Next diagnostic |
| `<leader>cd` | n | Line diagnostics (float) |
| `<leader>d` | n | Toggle diagnostics panel (Trouble) |
| `<leader>sd` | n | Document diagnostics (Telescope) |
| `<leader>sD` | n | Workspace diagnostics (Telescope) |

### Telescope — Search & Find

| Key | Mode | Action |
|-----|------|--------|
| `<leader><space>` / `<leader>ff` | n | Find project files |
| `<leader>/` / `<leader>fg` | n | Live grep (root) / Grep |
| `<C-p>` | n | Git files |
| `<leader>sa` | n | Auto commands |
| `<leader>sb` | n | Current buffer fuzzy find |
| `<leader>sc` | n | Command history |
| `<leader>sC` | n | Commands |
| `<leader>sh` | n | Help tags |
| `<leader>sH` | n | Highlight groups |
| `<leader>sk` | n | Keymaps |
| `<leader>sm` | n | Marks |
| `<leader>sM` | n | Man pages |
| `<leader>so` | n | Vim options |
| `<leader>sr` | n | Resume last picker |
| `<leader>st` | n | Todo comments |
| `<leader>su` | n | Undo history |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `[h` / `]h` | n | Previous / Next hunk (Gitsigns) |
| `<leader>gl` | n | LazyGit (`:LazyGit`) |
| `<leader>gc` | n | Telescope commits |
| `<leader>gv` | n | Telescope git status |
| `<leader>gd` | n | Gitsigns diff this buffer |
| `<leader>gs` / `<leader>gS` | n | Stage hunk / Stage buffer |
| `<leader>gu` | n | Undo stage hunk |
| `<leader>gtb` | n | Toggle current line blame |
| `<leader>gtd` | n | Toggle deleted lines |
| `<leader>grh` | n | Reset hunk |
| `<leader>grb` | n | Reset buffer |

### Opencode

| Key | Mode | Action |
|-----|------|--------|
| `<C-a>` | n, x | Ask Opencode `@this` (submit) |
| `<C-x>` | n, x | Select / Execute Opencode action |
| `<C-.>` | n, t | Toggle Opencode terminal (right, `snacks.terminal`) |
| `go` | n, x | Add range to Opencode (`@this`) — operator (expr) |
| `goo` | n | Add line to Opencode (`@this`) |
| `<S-C-u>` | n | Scroll Opencode half-page up |
| `<S-C-d>` | n | Scroll Opencode half-page down |
| `+` | n | Increment number (`<C-a>`) |
| `-` | n | Decrement number (`<C-x>`) |

### Utilities

| Key | Mode | Action |
|-----|------|--------|
| `gcc` / `gc` | n / v | Toggle comment |
| `ys` / `cs` / `ds` | n | Add / Change / Delete surroundings (`nvim-surround`) |
| `<leader>co` | n | Toggle Treesitter context (`TSContextToggle`) |
| `<C-t>` | n, t | Toggle terminal (`toggleterm`) |
| `<esc>` | t | Exit terminal mode |

### Completion (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<C-n>` / `<C-j>` | i | Next item |
| `<C-p>` / `<C-k>` | i | Previous item |
| `<Tab>` | i | Confirm if visible & non-empty line, else fallback |
| `<S-Tab>` | i | Close completion |
| `<C-Space>` | i | Trigger completion |
| `<C-d>` / `<C-f>` | i | Scroll docs -4 / +4 |
| `<Down>` / `<Up>` | i | Next / Prev item or expand/jump snippet (luasnip) |

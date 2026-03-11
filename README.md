# nvim-config

Personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Installation

### Prerequisites

- Neovim >= 0.11 (stable)
- git, make, unzip, gcc
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- [A Nerd Font](https://www.nerdfonts.com/) (config expects one by default)
- Node.js / npm (for markdown-preview, prettier, ts_ls)
- Clipboard tool (`xclip` or `xsel` on Linux)

### Install

Back up your existing config if needed, then:

```sh
git clone git@github.com:etapsc/nvim-config.git ~/.config/nvim
```

Start Neovim — Lazy will auto-install all plugins on first launch:

```sh
nvim
```

Run `:checkhealth` to verify everything is working.

## What's Included

### Core (init.lua)

- **Plugin manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Fuzzy finder**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) with fzf-native
- **LSP**: nvim-lspconfig + Mason (auto-installs servers)
- **Autocompletion**: [blink.cmp](https://github.com/saghen/blink.cmp) + LuaSnip
- **Formatting**: [conform.nvim](https://github.com/stevearc/conform.nvim) (format on save)
- **Treesitter**: syntax highlighting, indentation
- **Which-key**: shows pending keybinds
- **Mini.nvim**: ai textobjects, surround, bufremove

### Enabled Kickstart Modules (`lua/kickstart/plugins/`)

| Plugin | Description |
| ------ | ----------- |
| autopairs | Auto-close brackets and quotes |
| gitsigns | Git gutter signs + hunk actions (`<leader>h`) |
| indent_line | Indentation guides |
| lint | Linting via nvim-lint (ruff, eslint_d, markdownlint) |
| neo-tree | File explorer (`\` to toggle) |
| debug | DAP debugger (Go via delve) |

### Custom Plugins (`lua/custom/plugins/`)

| Plugin | Description |
| ------ | ----------- |
| bufferline | Tab-style buffer bar (`Tab`/`S-Tab` to cycle) |
| lualine | Statusline |
| noice | Enhanced UI for cmdline, messages, notifications |
| theme | Catppuccin (mocha) + Tokyonight (`<leader>ut` to toggle) |
| markdown | Markdown preview in browser |
| diffview | Visual git diff viewer and file history |
| neogit | Interactive git status, commit, push/pull |

### LSP Servers (auto-installed via Mason)

clangd, gopls, pyright, rust_analyzer, ts_ls, lua_ls, marksman

### Formatters & Linters (auto-installed via Mason)

black, isort, prettier, ruff, eslint_d, markdownlint, stylua

## Key Mappings

Leader key is `Space`. Run `:WhichKey` to see all available mappings interactively.

### Search (Telescope)

| Key | Action |
| --- | ------ |
| `<leader>sf` | Search files |
| `<leader>sg` | Search by grep (across project) |
| `<leader>sw` | Search current word under cursor |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sc` | Search commands |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Search recent files |
| `<leader>s/` | Grep in open files only |
| `<leader>sn` | Search Neovim config files |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader><leader>` | Find open buffers |

### Buffers and Windows

| Key | Action |
| --- | ------ |
| `Tab` | Next buffer |
| `S-Tab` | Previous buffer |
| `<leader>x` | Close buffer (keeps window layout) |
| `<leader>X` | Pick a buffer to close |
| `<leader><Left>` | Focus window left |
| `<leader><Right>` | Focus window right |
| `<leader><Down>` | Focus window below |
| `<leader><Up>` | Focus window above |
| `:split` | Horizontal split |
| `:vsplit` | Vertical split |
| `<C-w>=` | Equalize split sizes |
| `<C-w>o` | Close all other windows |
| `<C-w>T` | Move current window to new tab |

### File Explorer (Neo-tree)

| Key | Action |
| --- | ------ |
| `\` | Toggle Neo-tree sidebar |
| `\` (inside tree) | Close Neo-tree |
| `<CR>` | Open file / expand directory |
| `a` | Create file (add `/` suffix for directory) |
| `d` | Delete file |
| `r` | Rename file |
| `c` | Copy file |
| `m` | Move file |
| `H` | Toggle hidden files |
| `R` | Refresh |

### Git — Neogit (interactive status)

| Key | Action |
| --- | ------ |
| `<leader>gs` | Open git status panel |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gl` | Git pull |
| `q` | Close Neogit panel |

Inside the Neogit status panel:

| Key | Action |
| --- | ------ |
| `s` | Stage file / hunk under cursor |
| `u` | Unstage file / hunk |
| `x` | Discard changes |
| `c` | Open commit popup |
| `p` | Open push popup |
| `F` | Open pull popup |
| `b` | Open branch popup |
| `l` | Open log popup |
| `Tab` | Toggle diff inline |
| `<CR>` | Open file |

### Git — Diffview (visual diffs)

| Key | Action |
| --- | ------ |
| `<leader>gd` | Open diff view (all changes vs index) |
| `<leader>gh` | File history (current file) |
| `<leader>gH` | File history (entire branch) |
| `<leader>gq` | Close diff view (restores previous layout) |
| `q` | Close diff view (from any diffview panel) |

### Git — Gitsigns (inline hunks)

| Key | Action |
| --- | ------ |
| `]c` / `[c` | Jump to next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hR` | Reset entire buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame current line |
| `<leader>hd` | Diff against index |
| `<leader>hD` | Diff against last commit |
| `<leader>tb` | Toggle inline blame |

### LSP

| Key | Action |
| --- | ------ |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Find references |
| `grd` | Go to definition |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `grD` | Go to declaration |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |
| `<leader>f` | Format buffer |
| `<leader>q` | Open diagnostics quickfix list |

### Debugging (DAP)

| Key | Action |
| --- | ------ |
| `F5` | Start / continue |
| `F1` | Step into |
| `F2` | Step over |
| `F3` | Step out |
| `F7` | Toggle DAP UI |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |

### Other

| Key | Action |
| --- | ------ |
| `<leader>ut` | Toggle color theme |
| `<Esc>` | Clear search highlights |
| `<Esc><Esc>` | Exit terminal mode |
| `:MarkdownPreview` | Open markdown preview in browser |
| `:Lazy` | Plugin manager |
| `:Mason` | LSP/tool installer |
| `:WhichKey` | Show all keymaps |

## Customization

- Add plugins to `lua/custom/plugins/` — they are auto-loaded
- Edit `init.lua` for core settings and keymaps
- Run `:Mason` to manage LSP servers and tools
- Run `:Lazy` to manage plugins

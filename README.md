# SISUVim

SISUVim is a modern, dependency-free Vim and Neovim distribution. It preserves
the editing muscle memory that made spf13-vim productive, while starting with a
small, maintainable codebase for current Vim and Neovim.

## Goals

- Support Vim 9.0+ and Neovim 0.12+ from one repository.
- Keep familiar high-frequency mappings: window navigation, wrapped-line
  movement, tabs, folds, visual indentation, and current-file-directory edits.
- Use Neovim Lua for Neovim-specific configuration and Vim9-compatible
  Vimscript for Vim.
- Start without mandatory plugins or network downloads. Optional integrations
  will be added as separately documented modules.
- Remain an MIT-licensed project. No code from the Apache-2.0-licensed ancestor
  is copied into SISUVim.

## Install

Clone this repository, then link the appropriate entry point:

```sh
git clone https://github.com/relaxfinger/SISUVim.git ~/.config/sisuvim
ln -s ~/.config/sisuvim ~/.config/nvim
ln -s ~/.config/sisuvim/vimrc ~/.vimrc
```

For an existing configuration, back it up before creating links. `install.sh`
performs these checks and refuses to replace non-link files.

## Architecture

| Path | Role |
| --- | --- |
| `init.lua` | Neovim entry point |
| `lua/sisuvim/` | Neovim options, mappings, health check, and optional modules |
| `vimrc` | Vim entry point |
| `vim/sisuvim.vim` | Vim-compatible options and mappings |
| `docs/migration.md` | Mapping compatibility status and migration decisions |

## Verify

```sh
vim -Nu NONE -n -es '+source vimrc' '+qa'
nvim --clean --headless '+set rtp^=$PWD' '+luafile init.lua' '+qa'
```

Run `:checkhealth sisuvim` in Neovim for an environment report.

## Navigation and search

Neovim uses its native `vim.pack` package manager to install the optional
navigation module on first start. Confirm the prompted installation; package
revisions are persisted in Neovim's lockfile. The module keeps these mappings:

| Mapping | Action |
| --- | --- |
| `F5`, `<leader>e` | File explorer |
| `<leader>ff` | Find files |
| `<leader>fg` | Search project text |
| `<leader>fb` | Find open buffers |
| `<leader>fr` | Recent files |

When optional packages are unavailable, `F5` and `<leader>e` fall back to
Vim's built-in `:Explore`. Set `vim.g.sisuvim_disable_packages = true` before
loading SISUVim to disable package installation for a session.

## Git workflow

The Neovim Git module retains the Fugitive-style mappings from the previous
distribution: `<leader>gs/gd/gc/gb/gl/gp/gr/gw/ge/gi`. Gitsigns adds inline
change markers and hunk actions: `[c` / `]c` navigate, while
`<leader>hp/hs/hr` preview, stage, or reset a hunk. `<leader>gg` toggles signs.

These integrations are Neovim modules for now; Vim 9 keeps its dependency-free
core and will gain optional package installation in a later portability pass.

## LSP, completion, and formatting

SISUVim uses Neovim's built-in LSP client and completion instead of a separate
LSP framework. It automatically enables a server only when its executable is
available: `lua-language-server`, `typescript-language-server`,
`basedpyright-langserver`, `gopls`, `rust-analyzer`, or `clangd`.

Use `<leader>ld/lD/li/lr/la/ln` for definition, declaration, implementation,
references, code action, and rename. `<leader>lf` formats manually, and
`Ctrl-Space` requests completion. To opt into synchronous format-on-save, set
`vim.g.sisuvim_format_on_save = true` before SISUVim loads.

## License

MIT. See [LICENSE](LICENSE).

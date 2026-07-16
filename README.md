# SISUVim

SISUVim is a modern Vim and Neovim distribution. It preserves a familiar,
keyboard-first editing workflow while keeping a small, maintainable codebase
for current Vim and Neovim.

## Goals

- Support Vim 9.0+ and Neovim 0.12+ from one repository.
- Keep familiar high-frequency mappings: window navigation, wrapped-line
  movement, tabs, folds, visual indentation, and current-file-directory edits.
- Use Neovim Lua for Neovim-specific configuration and Vim9-compatible
  Vimscript for Vim.
- Start without mandatory plugins or network downloads. Optional integrations
  will be added as separately documented modules.
- Remain an MIT-licensed project.

## Install

Clone this repository, then run the installer:

```sh
git clone https://github.com/relaxfinger/SISUVim.git ~/.config/sisuvim
~/.config/sisuvim/install.sh --with-packages
```

The installer moves existing configs to timestamped sibling backups before it
creates a link; it never deletes them. Use `--nvim`, `--vim`, or `--dry-run` to
limit or preview changes. On Windows PowerShell, run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\Install-SISUVim.ps1 -WithPackages
```

`--with-packages` installs Neovim packages at the exact revisions specified in
the configuration, and installs the compatible Vim package into Vim's native
package directory.

## Architecture

| Path | Role |
| --- | --- |
| `init.lua` | Neovim entry point |
| `lua/sisuvim/` | Neovim options, mappings, health check, and optional modules |
| `vimrc` | Vim entry point |
| `vim/sisuvim.vim` | Vim-compatible options and mappings |
| `Install-SISUVim.ps1` | Windows PowerShell installer |
| `scripts/install-packages.sh` | Reproducible optional package installer |
| `docs/keymaps.md` | Supported keymap contract |

## Verify

```sh
vim -Nu NONE -n -es '+source vimrc' '+qa'
nvim --clean --headless '+set rtp^=$PWD' '+luafile init.lua' '+qa'
./tests/smoke.sh
```

Run `:checkhealth sisuvim` in Neovim for an environment report.

## Navigation and search

Neovim uses a modular plugin specification powered by `lazy.nvim`. Optional
packages install on first start and their resolved revisions are persisted in
`lazy-lock.json`. The navigation module keeps these mappings:

| Mapping | Action |
| --- | --- |
| `F5`, `<leader>e` | File explorer |
| `<leader>pf` | Find files |
| `<leader>ff` | Find keyword occurrences |
| `<leader>fg` | Search project text |
| `<leader>fb` | Find open buffers |
| `<leader>fr` | Recent files |

When optional packages are unavailable, `F5` and `<leader>e` fall back to
Vim's built-in `:Explore`. Set `vim.g.sisuvim_disable_packages = true` before
loading SISUVim to disable package installation for a session.

## Git workflow

The Neovim Git module provides familiar Git workflow mappings:
`<leader>gs/gd/gc/gb/gl/gp/gr/gw/ge/gi`. Gitsigns adds inline
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

## Snippets

SISUVim uses Neovim's built-in snippet engine, including snippets returned by
language servers. `Ctrl-k` preserves the previous expand/jump habit: it moves
to the next snippet placeholder when one is active, otherwise it requests LSP
completion. `Ctrl-j` moves to the previous placeholder. No external snippet
engine or bundled snippet collection is required.

## Tree-sitter

Neovim can install modern Tree-sitter parsers and queries with
`:SisuTreesitterInstall`; provide language names to install only selected
parsers, for example `:SisuTreesitterInstall lua python`. The module enables
Tree-sitter highlighting, folds, and indentation only when a parser is
available, so regular syntax highlighting remains the safe fallback.

Parser installation requires `tree-sitter` CLI 0.26.1+, a C compiler, and
`curl`. Tree-sitter text objects are deliberately deferred: the upstream
ecosystem has recently made an incompatible rewrite, so SISUVim will add them
after the new API stabilizes.

## License

MIT. See [LICENSE](LICENSE).

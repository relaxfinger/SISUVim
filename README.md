# SISUVim

SISUVim is a modern, dependency-free Vim and Neovim distribution. It preserves
the editing muscle memory that made spf13-vim productive, while starting with a
small, maintainable codebase for current Vim and Neovim.

## Goals

- Support Vim 9.0+ and Neovim 0.10+ from one repository.
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

## License

MIT. See [LICENSE](LICENSE).

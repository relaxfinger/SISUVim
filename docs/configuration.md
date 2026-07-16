# Configuring SISUVim

SISUVim keeps personal settings outside the checked-out distribution. Create
the following file:

- macOS and Linux: `~/.config/sisuvim/config.lua`
- Windows: `%LOCALAPPDATA%\sisuvim\config.lua`

The file must return a Lua table. It is read before options, language tooling,
keymaps, and optional packages are configured.

```lua
local config = {
  disable_packages = false,
  format_on_save = true,
  options = {
    background = "light",
    number = true,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
    wrap = true,
  },
}

vim.keymap.set("n", "<leader>tt", ":tabnew<CR>", { silent = true })

return config
```

`options` is merged with SISUVim's defaults, so include only values you want to
change. `disable_packages = true` starts Neovim without installing or loading
optional packages. This is useful for troubleshooting and fully offline use.

For a one-off session, the existing global switches remain supported when set
before SISUVim loads:

```lua
vim.g.sisuvim_disable_packages = true
vim.g.sisuvim_format_on_save = true
```

Custom keymaps may be defined before `return config`. Avoid reassigning
mappings documented in [keymaps.md](keymaps.md) unless you intend to replace
that workflow locally.

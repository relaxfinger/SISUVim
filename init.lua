if vim.fn.has("nvim-0.12") == 0 then
  vim.api.nvim_echo({ { "SISUVim requires Neovim 0.12 or newer.", "ErrorMsg" } }, true, {})
  return
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("sisuvim")

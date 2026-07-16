if vim.fn.has("nvim-0.10") == 0 then
  vim.api.nvim_echo({ { "SISUVim requires Neovim 0.10 or newer.", "ErrorMsg" } }, true, {})
  return
end

require("sisuvim")

local M = {}

function M.setup()
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

  local opt = vim.opt
  for name, value in pairs(require("sisuvim.config").get().options) do
    opt[name] = value
  end

  vim.cmd.syntax("enable")

  if vim.fn.has("clipboard") == 1 then
    opt.clipboard:append("unnamedplus")
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("sisuvim_indent", { clear = true }),
    pattern = { "haskell", "javascript", "javascriptreact", "json", "lua", "ruby", "typescript", "typescriptreact", "yaml" },
    callback = function()
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
      vim.bo.softtabstop = 2
    end,
  })
end

return M

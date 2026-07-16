local M = {}

function M.setup()
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

  local opt = vim.opt
  opt.background = "dark"
  opt.number = true
  opt.cursorline = true
  opt.mouse = "a"
  opt.hidden = true
  opt.ignorecase = true
  opt.smartcase = true
  opt.incsearch = true
  opt.hlsearch = true
  opt.splitright = true
  opt.splitbelow = true
  opt.expandtab = true
  opt.shiftwidth = 4
  opt.tabstop = 4
  opt.softtabstop = 4
  opt.wrap = false
  opt.scrolloff = 3
  opt.sidescrolloff = 3
  opt.undofile = true
  opt.completeopt = { "menu", "menuone", "noselect" }

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

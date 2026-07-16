local M = {}

local navigation = {
  {
    src = "https://github.com/folke/snacks.nvim",
    version = "v2.31.0",
  },
}

function M.setup()
  if vim.g.sisuvim_disable_packages then
    return
  end

  vim.pack.add(navigation)

  local ok, snacks = pcall(require, "snacks")
  if not ok then
    return
  end

  snacks.setup({
    explorer = { enabled = true },
    picker = { enabled = true },
  })
end

return M

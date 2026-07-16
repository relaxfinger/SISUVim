local M = {}

function M.check()
  vim.health.start("SISUVim")
  if vim.fn.has("nvim-0.10") == 1 then
    vim.health.ok("Neovim version is supported")
  else
    vim.health.error("Neovim 0.10 or newer is required")
  end

  if vim.fn.executable("git") == 1 then
    vim.health.ok("git is available for optional modules")
  else
    vim.health.warn("git is not available; optional modules cannot be installed")
  end
end

return M

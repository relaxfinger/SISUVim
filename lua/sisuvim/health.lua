local M = {}

function M.check()
  vim.health.start("SISUVim")
  if vim.fn.has("nvim-0.12") == 1 then
    vim.health.ok("Neovim version is supported")
  else
    vim.health.error("Neovim 0.12 or newer is required")
  end

  if vim.fn.executable("git") == 1 then
    vim.health.ok("git is available for optional modules")
  else
    vim.health.warn("git is not available; optional modules cannot be installed")
  end

  if vim.g.sisuvim_disable_packages then
    vim.health.warn("Optional packages are disabled for this session")
  elseif vim.pack then
    vim.health.ok("Native vim.pack is available")
  else
    vim.health.error("Native vim.pack is unavailable")
  end
end

return M

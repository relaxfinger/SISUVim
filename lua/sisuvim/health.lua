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

  local config = require("sisuvim.config").get()
  if config.disable_packages then
    vim.health.warn("Optional packages are disabled for this session")
  elseif pcall(require, "lazy") then
    vim.health.ok("lazy.nvim is available")
  else
    vim.health.warn("Optional Neovim packages are not installed")
  end

  if vim.fn.executable("tree-sitter") == 1 then
    vim.health.ok("tree-sitter CLI is available for parser installation")
  else
    vim.health.warn("tree-sitter CLI is missing; :SisuTreesitterInstall cannot build parsers")
  end

  if vim.fn.filereadable(require("sisuvim.config").path()) == 1 then
    vim.health.ok("Local configuration is loaded")
  else
    vim.health.info("No local configuration file is present")
  end
end

return M

local M = {}

local function root()
  local source = debug.getinfo(1, "S").source:sub(2)
  return vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(source)))
end

function M.setup()
  if vim.g.sisuvim_disable_packages then
    return
  end

  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    if vim.fn.executable("git") == 0 then
      vim.notify("SISUVim needs git to install optional Neovim packages.", vim.log.levels.WARN)
      return
    end

    local result = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazy_path,
    })
    if vim.v.shell_error ~= 0 then
      vim.notify("SISUVim could not install lazy.nvim: " .. result, vim.log.levels.ERROR)
      return
    end
  end

  vim.opt.rtp:prepend(lazy_path)
  require("lazy").setup({
    spec = { { import = "sisuvim.plugins" } },
    defaults = { lazy = true },
    install = { missing = true, colorscheme = { "habamax" } },
    lockfile = root() .. "/lazy-lock.json",
    checker = { enabled = false },
    change_detection = { notify = false },
    performance = { rtp = { reset = false } },
  })
end

return M

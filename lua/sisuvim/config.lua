local M = {}

local defaults = {
  disable_packages = false,
  format_on_save = false,
  options = {
    background = "dark",
    completeopt = { "menu", "menuone", "noselect" },
    cursorline = true,
    expandtab = true,
    hidden = true,
    hlsearch = true,
    ignorecase = true,
    incsearch = true,
    mouse = "a",
    number = true,
    scrolloff = 3,
    shiftwidth = 4,
    sidescrolloff = 3,
    smartcase = true,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    tabstop = 4,
    undofile = true,
    wrap = false,
  },
}

local values = vim.deepcopy(defaults)
local configured = false

function M.path()
  return vim.fs.joinpath(vim.fs.dirname(vim.fn.stdpath("config")), "sisuvim", "config.lua")
end

function M.setup()
  if configured then
    return values
  end
  configured = true

  local path = M.path()
  if vim.fn.filereadable(path) == 1 then
    local chunk, load_error = loadfile(path)
    if not chunk then
      vim.notify("SISUVim could not read " .. path .. ": " .. load_error, vim.log.levels.ERROR)
    else
      local ok, user_values = pcall(chunk)
      if not ok then
        vim.notify("SISUVim could not load " .. path .. ": " .. user_values, vim.log.levels.ERROR)
      elseif type(user_values) ~= "table" then
        vim.notify("SISUVim local config must return a table: " .. path, vim.log.levels.ERROR)
      else
        values = vim.tbl_deep_extend("force", values, user_values)
      end
    end
  end

  if vim.g.sisuvim_disable_packages ~= nil then
    values.disable_packages = vim.g.sisuvim_disable_packages
  end
  if vim.g.sisuvim_format_on_save ~= nil then
    values.format_on_save = vim.g.sisuvim_format_on_save
  end

  return values
end

function M.get()
  return M.setup()
end

return M

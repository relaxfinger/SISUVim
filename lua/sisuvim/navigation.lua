local M = {}

local function snacks()
  local ok, value = pcall(require, "snacks")
  return ok and value or nil
end

function M.explorer()
  local value = snacks()
  if value then
    value.explorer.open()
  else
    vim.cmd("Explore")
  end
end

function M.files()
  local value = snacks()
  if value then
    value.picker.files()
  else
    vim.cmd("find **/*")
  end
end

function M.grep()
  local value = snacks()
  if value then
    value.picker.grep()
  else
    vim.cmd("vimgrep //gj **/*")
    vim.cmd("copen")
  end
end

function M.buffers()
  local value = snacks()
  if value then
    value.picker.buffers()
  else
    vim.cmd("buffers")
  end
end

function M.recent()
  local value = snacks()
  if value then
    value.picker.recent()
  else
    vim.cmd("oldfiles")
  end
end

return M

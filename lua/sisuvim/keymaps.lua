local M = {}
local navigation = require("sisuvim.navigation")

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

local function current_directory()
  local name = vim.api.nvim_buf_get_name(0)
  return name == "" and vim.fn.getcwd() or vim.fn.fnamemodify(name, ":p:h")
end

local function edit_in_current_directory(command)
  return function()
    vim.cmd(command .. " " .. vim.fn.fnameescape(current_directory()) .. "/")
  end
end

function M.setup()
  map("n", "<leader>bg", function()
    vim.o.background = vim.o.background == "dark" and "light" or "dark"
  end, "Toggle background")

  map({ "n", "v", "o" }, "j", "gj", "Move by display line")
  map({ "n", "v", "o" }, "k", "gk", "Move by display line")
  map("n", "Y", "y$", "Yank to end of line")
  map("n", "<C-h>", "<C-w>h<C-w>_", "Focus left window")
  map("n", "<C-j>", "<C-w>j<C-w>_", "Focus lower window")
  map("n", "<C-k>", "<C-w>k<C-w>_", "Focus upper window")
  map("n", "<C-l>", "<C-w>l<C-w>_", "Focus right window")
  map("n", "<S-h>", "gT", "Previous tab")
  map("n", "<S-l>", "gt", "Next tab")
  map("n", "<leader>/", "<cmd>nohlsearch<cr>", "Clear search highlight")
  map("n", "<leader>=", "<C-w>=", "Equalize windows")
  map("n", "zl", "zL", "Open all folds")
  map("n", "zh", "zH", "Close all folds")
  map("n", "<F5>", navigation.explorer, "Open file explorer")
  map("n", "<leader>e", navigation.explorer, "Open file explorer")
  map("n", "<leader>ff", navigation.files, "Find files")
  map("n", "<leader>fg", navigation.grep, "Grep project")
  map("n", "<leader>fb", navigation.buffers, "Find buffers")
  map("n", "<leader>fr", navigation.recent, "Find recent files")
  map("v", "<", "<gv", "Indent left and reselect")
  map("v", ">", ">gv", "Indent right and reselect")
  map("v", ".", ":normal .<cr>", "Repeat change on selection")

  map("n", "<leader>ew", edit_in_current_directory("edit"), "Edit in file directory")
  map("n", "<leader>es", edit_in_current_directory("split"), "Split in file directory")
  map("n", "<leader>ev", edit_in_current_directory("vsplit"), "Vertical split in file directory")
  map("n", "<leader>et", edit_in_current_directory("tabedit"), "Tab edit in file directory")

  for level = 0, 9 do
    map("n", "<leader>f" .. level, function()
      vim.wo.foldlevel = level
    end, "Set fold level " .. level)
  end
end

return M

local M = {}

local function fugitive(command)
  if vim.fn.exists(":" .. command:match("^%S+")) == 2 then
    vim.cmd(command)
  else
    vim.notify("SISUVim Git module is not installed yet. Restart Neovim and confirm package installation.", vim.log.levels.WARN)
  end
end

function M.setup_keymaps(map)
  map("n", "<leader>gs", function() fugitive("Git") end, "Git status")
  map("n", "<leader>gd", function() fugitive("Gdiffsplit") end, "Git diff")
  map("n", "<leader>gc", function() fugitive("Git commit") end, "Git commit")
  map("n", "<leader>gb", function() fugitive("Gblame") end, "Git blame")
  map("n", "<leader>gl", function() fugitive("Git log") end, "Git log")
  map("n", "<leader>gp", function() fugitive("Git push") end, "Git push")
  map("n", "<leader>gr", function() fugitive("Gread") end, "Git read")
  map("n", "<leader>gw", function() fugitive("Gwrite") end, "Git write")
  map("n", "<leader>ge", function() fugitive("Gedit") end, "Git edit")
  map("n", "<leader>gi", function() fugitive("Git add -p %") end, "Git add patch")
  map("n", "<leader>gg", function()
    local ok, gitsigns = pcall(require, "gitsigns")
    if ok then
      gitsigns.toggle_signs()
    else
      vim.notify("SISUVim Git signs are not installed yet.", vim.log.levels.WARN)
    end
  end, "Toggle Git signs")
end

return M

local M = {}

local packages = {
  {
    src = "https://github.com/folke/snacks.nvim",
    version = "v2.31.0",
  },
  {
    src = "https://github.com/tpope/vim-fugitive",
    version = "3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0",
  },
  {
    src = "https://github.com/lewis6991/gitsigns.nvim",
    version = "31d6fb2d618bca1482b9f274751ead5f03461408",
  },
}

function M.setup()
  if vim.g.sisuvim_disable_packages then
    return
  end

  vim.pack.add(packages)

  local ok, snacks = pcall(require, "snacks")
  if ok then
    snacks.setup({
      explorer = { enabled = true },
      picker = { enabled = true },
    })
  end

  local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
  if gitsigns_ok then
    gitsigns.setup({
      current_line_blame = false,
      on_attach = function(buffer)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, silent = true, desc = desc })
        end

        map("n", "]c", gitsigns.next_hunk, "Next Git hunk")
        map("n", "[c", gitsigns.prev_hunk, "Previous Git hunk")
        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Git hunk")
        map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Git hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Git hunk")
      end,
    })
  end
end

return M

return {
  {
    "tpope/vim-fugitive",
    commit = "3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0",
    lazy = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      on_attach = function(buffer)
        local gitsigns = require("gitsigns")
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buffer, silent = true, desc = desc })
        end

        map("]c", gitsigns.next_hunk, "Next Git hunk")
        map("[c", gitsigns.prev_hunk, "Previous Git hunk")
        map("<leader>hp", gitsigns.preview_hunk, "Preview Git hunk")
        map("<leader>hs", gitsigns.stage_hunk, "Stage Git hunk")
        map("<leader>hr", gitsigns.reset_hunk, "Reset Git hunk")
      end,
    },
  },
}

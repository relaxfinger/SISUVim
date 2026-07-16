local M = {}

local languages = {
  "bash",
  "c",
  "css",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "rust",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

local function configure_buffer(event)
  if not pcall(vim.treesitter.start, event.buf) then
    return
  end

  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

function M.setup()
  local ok, treesitter = pcall(require, "nvim-treesitter")
  if not ok then
    return
  end

  treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

  vim.api.nvim_create_user_command("SisuTreesitterInstall", function(command)
    local requested = #command.fargs == 0 and languages or command.fargs
    treesitter.install(requested)
  end, {
    nargs = "*",
    complete = "filetype",
    desc = "Install SISUVim Tree-sitter parsers",
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("sisuvim_treesitter", { clear = true }),
    callback = configure_buffer,
  })
end

return M

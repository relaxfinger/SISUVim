local M = {}

function M.expand_or_complete()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
  else
    vim.lsp.completion.get()
  end
end

function M.jump_previous()
  if vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
  end
end

return M

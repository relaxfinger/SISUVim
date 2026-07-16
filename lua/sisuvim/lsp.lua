local M = {}

local servers = {
  {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
  {
    name = "ts_ls",
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  },
  {
    name = "basedpyright",
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
  },
  {
    name = "gopls",
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
  },
  {
    name = "rust_analyzer",
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
  },
  {
    name = "clangd",
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  },
}

local function configure_server(server)
  if vim.fn.executable(server.cmd[1]) == 0 then
    return
  end

  vim.lsp.config(server.name, {
    cmd = server.cmd,
    filetypes = server.filetypes,
    root_markers = server.root_markers,
    settings = server.settings,
  })
  vim.lsp.enable(server.name)
end

local function setup_attach_behavior()
  local group = vim.api.nvim_create_augroup("sisuvim_lsp", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(event)
      local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })

      local function map(lhs, rhs, description)
        vim.keymap.set("n", lhs, rhs, { buffer = event.buf, silent = true, desc = description })
      end

      map("<leader>ld", vim.lsp.buf.definition, "LSP definition")
      map("<leader>lD", vim.lsp.buf.declaration, "LSP declaration")
      map("<leader>li", vim.lsp.buf.implementation, "LSP implementation")
      map("<leader>lr", vim.lsp.buf.references, "LSP references")
      map("<leader>la", vim.lsp.buf.code_action, "LSP code action")
      map("<leader>ln", vim.lsp.buf.rename, "LSP rename")
      map("<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, "LSP format")

      if vim.g.sisuvim_format_on_save and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = group,
          buffer = event.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = event.buf, async = false, id = client.id })
          end,
        })
      end
    end,
  })
end

function M.setup()
  vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 2 },
  })

  vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, {
    silent = true,
    desc = "Trigger LSP completion",
  })

  setup_attach_behavior()
  for _, server in ipairs(servers) do
    configure_server(server)
  end
end

return M

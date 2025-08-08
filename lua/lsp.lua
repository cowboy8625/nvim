-- ============================================================================
-- LSP
-- ============================================================================

vim.o.winborder = "rounded"

-- Function to find project root
local function find_root(patterns)
  local path = vim.fn.expand("%:p:h")
  local root = vim.fs.find(patterns, { path = path, upward = true })[1]
  return root and vim.fn.fnamemodify(root, ":h") or path
end

-- Shell LSP setup
local function setup_shell_lsp()
  vim.lsp.start({
    name = "bashls",
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash", "zsh" },
    root_dir = find_root({ ".git", "Makefile" }),
    settings = {
      bashIde = {
        globPattern = "*@(.sh|.inc|.bash|.command)",
      },
    },
  })
end

-- Auto-start LSPs based on filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh,bash,zsh",
  callback = setup_shell_lsp,
  desc = "Start shell LSP",
})

local function setup_rust_lsp()
  vim.lsp.start({
    name = "rust",
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = find_root({ "Cargo.toml", ".git", "src" }),
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = setup_rust_lsp,
  desc = "Start Python LSP",
})

vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "*.rs",
  callback = function()
    -- This stops *all* attached LSP clients for the current buffer
    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(clients) do
      client:stop()
    end
  end,
  desc = "Stop Rust LSP when buffer is unloaded",
})

local function setup_python_lsp()
  vim.lsp.start({
    name = "pylsp",
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_dir = find_root({ "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }),
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            enabled = false,
          },
          flake8 = {
            enabled = true,
          },
          black = {
            enabled = true,
          },
        },
      },
    },
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = setup_python_lsp,
  desc = "Start Python LSP",
})

vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "*.py",
  callback = function()
    -- This stops *all* attached LSP clients for the current buffer
    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(clients) do
      client:stop()
    end
  end,
  desc = "Stop Python LSP when buffer is unloaded",
})

local function setup_zig_lsp()
  vim.lsp.start({
    name = "zig-lsp",
    cmd = { "zls" },
    filetypes = { "zig" },
    root_dir = find_root({ ".git", "build.zig", "build.zig.zon" }),
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "zig",
  callback = setup_zig_lsp,
  desc = "Start Zig LSP",
})

vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "*.zig",
  callback = function()
    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(clients) do
      client:stop()
    end
  end,
  desc = "Stop Zig LSP when buffer is unloaded",
})

local function setup_lua_lsp()
  vim.lsp.start({
    name = "lua-language-server",
    cmd = { "lua-language-server" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", ".luarc.json", ".luarc.jsonc" }, { upward = true })[1]),
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          version = "LuaJIT",
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false, -- avoid prompts
        },
        diagnostics = {
          globals = { "vim" }, -- recognize 'vim' global
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = setup_lua_lsp,
})

-- ================================================================================================
--                                    LSP Keymaps
-- ================================================================================================

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    -- Information
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

    -- Code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Diagnostics
    vim.keymap.set("n", "<leader>nd", function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)
    vim.keymap.set("n", "<leader>pd", function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
  end,
})

-- Better LSP UI
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✗",
      [vim.diagnostic.severity.WARN] = "⚠",
      [vim.diagnostic.severity.INFO] = "ℹ",
      [vim.diagnostic.severity.HINT] = "💡",
    },
  },
})

vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached to current buffer")
  else
    for _, client in ipairs(clients) do
      print("LSP: " .. client.name .. " (ID: " .. client.id .. ")")
    end
  end
end, { desc = "Show LSP client info" })

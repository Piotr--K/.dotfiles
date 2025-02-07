-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--  Note:
--  scala has metals, installed on the system
local servers = {
  -- clangd = {},
  gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  hls = {},
  ts_ls = {},
  clojure_lsp = {},
  -- eslint = {},
  -- prettier,
  solc = {},
  yamlls = {},

  -- solidity_ls = {
    -- cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
    -- filetypes = {'solidity'},
    -- root_dir = require('lspconfig').util.find_git_ancestor,
    -- single_file_support = true,
  -- },
  -- solidity = {
  --   cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
  --   filetypes = {'solidity'},
  --   root_dir = require('lspconfig.util').find_git_ancestor,
  --   single_file_support = true,
  -- },
  --TODO - clean it up - recently disabled due to problems while running :so
  -- sumneko_lua = {
  --   Lua = {
  --     workspace = { checkThirdParty = false },
  --     telemetry = { enable = false },
  --   },
  -- },
}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
--  via calling it from mason below
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  -- print("Piotr we got here")
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  vim.keymap.set('n','<leader>m', '<cmd>lua require("telescope").extensions.metals.commands()<CR>') --, '[O]pens [M]etals Picker')

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>T', vim.lsp.buf.hover, 'Hover [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- is this not the same as leaderT above ?? TODO: clean it up
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- trying to remap sexp clashing mapping
  vim.keymap.set('n', '<leader>|', "<Plug>(sexp_convolute)", { noremap = true, silent = true })
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- scala setup
local metals_config = require("metals").bare_config()
-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  -- this is from: https://github.com/scalameta/nvim-metals/blob/main/doc/metals.txt#L68
  -- and should allow to select test suite or test case
  testUserInterface = "Test Explorer",
}
--remove statusbar if it interfere with other statuses
metals_config.init_options.statusBarProvider = "on"
-- metals_config.on_attach = on_attach
metals_config.on_attach = function(client, bufnr)
  on_attach(client, bufnr)
  require("metals").setup_dap()
end

local api = vim.api
local nvim_metals_group = api.nvim_create_augroup('nvim-metals', { clear = true })
api.nvim_create_autocmd('FileType', {
  pattern = { 'scala', 'sbt', 'java' },
  callback = function()
    require('metals').initialize_or_attach(metals_config)
    -- TODO: metals: fix this
    -- vim.api.nvim_command("augroup LuaScript")
    -- vim.api,nvim_command("autocmd!")
    -- vim.api.nvim_command("autocmd BufEnter * lua require ('init.lua').on_attach(client, buffer)")
    -- vim.api.nvim_command("augroup END")
    -- on_attach({}, vim.api.nvim_get_current_buf())
  end,
  group = nvim_metals_group,
})
-- haskell setups - clean it up: this is part of haskell-tools
-- vim.g.haskell_tools = {
--    ---@type ToolsOpts
--    tools = {
--      -- ...
--    },
--    ---@type HaskellLspClientOpts
--    hls = {
--      on_attach = function(client, bufnr)
--        -- Set keybindings, etc. here.
--       -- on_attach(client, bufnr)
--      end,
--      -- ...
--    },
--    ---@type HTDapOpts
--    dap = {
--      -- ...
--    },
--  }
-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name]
      -- cmd = servers[server_name].cmd,
      -- filetypes = servers[server_name].filetypes,
      -- root_dir = servers[server_name].root_dir,
      -- single_file_support = servers[server_name].single_file_support,
      -- TODO: in orig file i have flags = lsp_flags
    }
  end,
}

-- install linters, remaining are in linters.lua
-- TODO: consider moving this setup there as well
require('mason-nvim-lint').setup({
  ensure_installed = {
    'prettier',
  },
})

require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

-- Turn on lsp status information
require('fidget').setup()

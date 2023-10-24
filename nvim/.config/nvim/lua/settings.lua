-- lua-tree related configs
-- where we disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
-- vim.opt.termguicolors = true
-- vim.cmd [[colorscheme onedark]]
-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd [[colorscheme nightfox]] 

vim.cmd [[colorscheme rose-pine]]
-- vim.cmd("highlight Cursor guifx=rose guibg=rose")

-- setting transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]

-- metals build progress
vim.g.metals_show_status = 'window'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
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

-- Metals Setup - TODO: move this somewhere
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

-- i want to evaluate vimscript code from lua
vim.api.nvim_exec(
[[
  let g:conjure#client#clojure#nrepl#mapping#session_fresh = 'sz'
]], false)

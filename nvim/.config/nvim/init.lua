-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- lua-tree related configs
-- where we disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('packer').startup(function(use)
  -- Package manager
use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  -- file explorer
  -- some settings related to this plugin are
  -- at the top of the file, eg to disable
  -- netrw
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week
  }

  -- Debugger via dap adapter
  use 'mfussenegger/nvim-dap'
    local dap = require('dap')
  -- mappings TODO: move those to separate file
    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
    vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
    vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint() end)
    vim.keymap.set('n', '<leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    -- conditional breakpoint, where:
    -- first arg passed needs to be a boolean condition
    -- and second argument needs to be a number indicating how many times line needs to be hit before execution pauses on the breakpoint
    vim.keymap.set('n', '<leader>bc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '), vim.fn.input('Hit count: '), nil) end)
    vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
    vim.keymap.set('n', '<leader>dc', function() require('dap').repl.close() end)
    vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
    vim.keymap.set('n', '<leader>dx', function() require('dap').clear_breakpoints() end)
    vim.keymap.set('n', '<leader>da', function() require('dap').list_breakpoints() end)
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)
  -- client
    dap.defaults.fallback.terminal_win_cmd = 'belowright new'
    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "Run or Test Target",
        metals = {
          runType = "runOrTestFile",
        },
      },
      {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
          runType = "testTarget",
        },
      },
    }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'
  use 'idbrii/vim-notgrep'
  -- use 'tpope/vim-commentary' -- TODO: probably dont need this as have Comment below
  -- use 'p00f/nvim-ts-rainbow' -- TODO: its not maintained anymore - check alternatives
  -- nvim change history, keymapping below
  -- vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
  use 'mbbill/undotree'
  -- use 'hiphish/nvim-ts-rainbow2'
  use 'mrjones2014/nvim-ts-rainbow'
  -- use 'luochen1990/rainbow'
  -- use 'junegunn/rainbow_parentheses.vim'

  -- Colorschemes
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines, "gb" - block comment
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  -- few to try
  use 'EdenEast/nightfox.nvim' -- to use do: vim.cmd('colorscheme nightfox')
  use 'folke/tokyonight.nvim' -- vim.cmd('colorscheme tokyonight') or vim.cmd[[colorscheme tokyonight]]
  -- this will run tokyonight default schema to run variants [storm, night, moon, day] do
  -- require("tokyonight").setup({
  --  style = "storm"
  --  )}) 
  --  more settings on: https://github.com/folke/tokyonight.nvim

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Adding nvim-metals
  use { 'scalameta/nvim-metals', requires = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' } }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  -- TODO: do this plugin composition via lua folder structure and 
  -- requires hierarchicly
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- my extension directories where i will be placing
-- additional to starter configuration plugins
-- require('after')
-- require('custom')

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


-- rainbox configuration - TODO: can i use some lua form rather?
-- set to 0 if you want to enable it later via :RainbowToggle
-- vim.g.rainbow_active = 1

-- [[ Setting options ]]
-- See `:help vim.o`

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
-- vim.cmd [[colorscheme onedark]]
-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd [[colorscheme nightfox]] 
require('rose-pine').setup({
  --- @usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    -- comment = 'iris',
    comment = 'muted',
    link = 'foam',
  }
})
vim.cmd [[colorscheme rose-pine]]

-- setting transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]

-- metals build progress
vim.g.metals_show_status = 'window'

-- remove default mapping to NOTHING,
-- because its pissing me off
-- clashing with buffer search <leader>?
-- require('custom').setup {
--   sexp_mappings = {
--     ["<leader>?"] = nil
--   }
-- }
-- vim.api.nvim_set_keymap('n', '', "<Plug>(sexp_convolute)", { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>|', "<Plug>(sexp_convolute)", { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>|', "<Plug>(sexp_convolute)", { silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
-- keymapping for undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'molokai',
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    path_display = { truncate = 3 }
  },
}

-- pcall(require('telescope').load_extension, 'metals')
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- require('telescope.builtin').find_files{ path_display = { "truncate" }}
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sp', function()
  -- TODO: i've added this, would like to change it to Ack
  require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').man_pages, { desc = '[S]earch [M]anual' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[P]revious [P]icker' })

-- using defaults
-- below are example of alternative configuration
require("nvim-tree").setup({
  diagnostics = {
    enable = true,
-- TODO: setup icons for hint/info/warning/error if defaults don't work
  },
  view = {
    width = 30,
  },
  update_focused_file = {
    enable = true
  }

})
-- require("nvim-tree").setup({
--   sort_by = "case_sensitive",
--   view = {
--     width = 30,
--     mappings = {
--       list = {
--         { key = "u", action = "dir_up" },
--       },
--     },
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })
-- local rainbow = require 'ts-rainbow'
local tree_api = require('nvim-tree.api')
vim.keymap.set('n', '<leader>xx', tree_api.tree.toggle)
-- default keymappings here: https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt

require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim', 'clojure', 'scala' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
  rainbow = {
    enable = true,
    -- disabling temporary to play with another fork of ts-rainbow
    -- query = {
    --   'rainbow-parens'
    -- },
    -- strategy = {
    --   rainbow.strategy.global,
    --   commonlisp = rainbow.strategy['local'],
    -- },
  },
  -- rainbow = {
  --   -- this is from:
  --   -- https://github.com/p00f/nvim-ts-rainbow
  --   enable = true,
  --   extended_mode = true,
  --   max_file_lines = nil,
  -- },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
-- remap for allowing multiple paste/replace
vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('n', '*', '*zz', {desc = 'Search and center the screen'})
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

--move text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

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

-- TODO: add dap config for debugging
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


-- End of metals configuration

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  clojure_lsp = {},
  -- TODO: scala lsp server
  -- TODO: colors scheme and transparency
  -- TODO: clojure specific plugins

  --TODO - clean it up - recently disabled due to problems while running :so
  -- sumneko_lua = {
  --   Lua = {
  --     workspace = { checkThirdParty = false },
  --     telemetry = { enable = false },
  --   },
  -- },
}

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
      settings = servers[server_name],
      -- TODO: in orig file i have flags = lsp_flags
    }
    -- TODO: scala: I've added it, lets see if its gonna work
    -- this is a default configuration
    -- i will need for it metals installed locally
    -- eg via Coursier: cs install metals
    -- the other option is to use nvim-metals plugin,
    -- which possibly handles metals installation, so maybe i wouldn'the
    -- need to ensure Coursier metal installation
    -- ALSO: how do i call metals import, clear etc
    -- require('lspconfig').metals.setup{
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- i want to evaluate vimscript code from lua
vim.api.nvim_exec(
[[
  let g:conjure#client#clojure#nrepl#mapping#session_fresh = 'sz'
]], false)
-- metals TODOS:
-- 1. set showImplicitArguments to true to display in hover
-- 2. maybe set showImplicitConversionsAndClasses, which also would be displayed in hover
-- 3. map some of more useful metal commands, eg. organize_imports
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

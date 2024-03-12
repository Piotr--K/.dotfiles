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
      { 'j-hui/fidget.nvim', tag = 'legacy' },

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
  }

  -- Debugger via dap adapter
  use 'mfussenegger/nvim-dap'

  -- Git related plugins
  use 'github/copilot.vim'
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
  -- few to try
  use 'EdenEast/nightfox.nvim' -- to use do: vim.cmd('colorscheme nightfox')
  use 'folke/tokyonight.nvim' -- vim.cmd('colorscheme tokyonight') or vim.cmd[[colorscheme tokyonight]]
  -- this will run tokyonight default schema to run variants [storm, night, moon, day] do
  -- require("tokyonight").setup({
  --  style = "storm"
  --  )}) 
  --  more settings on: https://github.com/folke/tokyonight.nvim

  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines, "gb" - block comment
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  --TODO: i've disabled it temp as it didnt work for me
  --ive configured nvim-ts-rainbow to try out
  --thats using treesitter
  -- "luochen1990/rainbow",
  use 'Olical/conjure'
  use 'radenling/vim-dispatch-neovim'
  use 'clojure-vim/vim-jack-in'
  use({ 'rose-pine/neovim', as = 'rose-pine'})

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Adding nvim-metals
  use { 'scalameta/nvim-metals', requires = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' } }

  -- haskell
  -- this plugin automatically configures the haskell-language-server builtin LSP client and integrates
  -- with other haskell tools, you just need some mappings
  use { 'mrcjkb/haskell-tools.nvim', versions = '^3', ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' }, }

  use 'leoluz/nvim-dap-go'

  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  --typescript
  use 
    { 
      "microsoft/vscode-js-debug",
      opt = true,
      run = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
      requires = {"mfussenegger/nvim-dap"}
    }
  use 
  { 
    "mxsdev/nvim-dap-vscode-js",
    requires = {"microsoft/vscode-js-debug"}
  }

  if is_bootstrap then
    require('packer').sync()
  end
end)


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

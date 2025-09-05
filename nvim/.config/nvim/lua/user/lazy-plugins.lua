-- Plugin specifications for lazy.nvim
return {
  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-lint",
      "rshkarin/mason-nvim-lint",
      { "j-hui/fidget.nvim", tag = "v1.4.5" },
      "folke/neodev.nvim",
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Debugger
  { "mfussenegger/nvim-dap" },
  { "leoluz/nvim-dap-go" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },

  -- TypeScript/JavaScript Debugging
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  -- AI Copilot (using github/copilot.vim as in your main branch)
  { "github/copilot.vim" },

  -- Git
  { "tpope/vim-rhubarb" },
  { "lewis6991/gitsigns.nvim" },
  { "idbrii/vim-notgrep" },
  { "NeogitOrg/neogit" },
  { "sindrets/diffview.nvim" },

  -- Utilities
  { "mbbill/undotree" },
  { "HiPhish/rainbow-delimiters.nvim" },

  -- Colorschemes (matching your main branch - no navarasu, EdenEast, folke)
  { "rose-pine/neovim", name = "rose-pine" },

  -- UI Enhancements
  { "nvim-lualine/lualine.nvim" },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "numToStr/Comment.nvim" },

  -- Editor Enhancements
  { "tpope/vim-sleuth" },
  { "guns/vim-sexp" },
  { "tpope/vim-sexp-mappings-for-regular-people" },
  { "Olical/conjure" },
  { "radenling/vim-dispatch-neovim" },
  { "clojure-vim/vim-jack-in" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },

  -- Language specific
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
  },

  -- Schema support
  { "b0o/schemastore.nvim" },

  -- Formatting and Linting (cleaned up - only keeping conform.nvim)
  { "mfussenegger/nvim-lint" },
  { "stevearc/conform.nvim" },

  -- REPL
  { "Vigemus/iron.nvim" },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()
    end,
  },

  -- AI Code Companion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "ravitemer/mcphub.nvim",
        config = function()
          require("mcphub").setup({
            cmd = "mcp-hub",
            cmdArgs = {},
          })
        end,
      },
    },
    config = function()
      require("codecompanion").setup({
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true,
              make_vars = true,
              make_slash_commands = true,
            },
          },
        },
      })
    end,
  },
}
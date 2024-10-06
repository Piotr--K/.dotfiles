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

-- i want to evaluate vimscript code from lua
-- vim.api.nvim_exec(
-- [[
--   let g:conjure#client#clojure#nrepl#mapping#session_fresh = 'sz'
--
--   let g:conjure#filetype#javascript = "node"
--   let g:conjure#client#node#stdio#command = "node-repl"
-- ]], false)

vim.g["conjure#client#clojure#nrepl#mapping#session_fresh"] = "sz"

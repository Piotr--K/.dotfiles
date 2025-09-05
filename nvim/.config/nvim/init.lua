require('user')
require('settings')
require('keymaps')

-- Set clipboard to use system clipboard  
vim.opt.clipboard = "unnamedplus"

-- Ctrl-p will show current file path
vim.api.nvim_set_keymap('n', '<C-p>', ":echo expand('%:p')<CR>", {noremap = true, silent = true})
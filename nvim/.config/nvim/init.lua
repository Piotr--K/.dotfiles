require('user')
require('settings')
require('keymaps')

-- Set clipboard to use system clipboard  
vim.opt.clipboard = "unnamedplus"

-- Ctrl-p will show current file path
vim.keymap.set('n', '<C-p>', ":echo expand('%:p')<CR>", { desc = 'Show current file path', noremap = true, silent = true })
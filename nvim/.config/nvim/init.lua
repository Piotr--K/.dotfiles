require('user')
require('settings')
require('keymaps')

-- Ctrl-p will show current file path
vim.keymap.set('n', '<C-p>', ":echo expand('%:p')<CR>", { desc = 'Show current file path', noremap = true, silent = true })

-- toggle whitespace display
-- Whitespace display toggle (currently disabled) - use :set list! manually if needed
-- vim.api.nvim_set_keymap('n', '<F5>', ':set list!<CR>', { noremap = true, silent = true })
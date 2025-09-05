require('user')
require('settings')
require('keymaps')

-- Ctrl-p will show current file path
vim.api.nvim_set_keymap('n', '<C-p>', ":echo expand('%:p')<CR>", {noremap = true, silent = true})

-- toggle whitespace display
-- TODO: replace this with something better
-- vim.api.nvim_set_keymap('n', '<F5>', ':set list!<CR>', { noremap = true, silent = true })
require('user')
require('settings')
require('keymaps')
-- Ctr-p will show current file path
vim.api.nvim_set_keymap('n', '<C-p>', ":echo expand('%:p')<CR>", {noremap = true, silent = true})
-- recompile whenever packer file is modified
-- consider using PackerCompile rather than PackerSync
-- augroup packer_user_config
--  autocmd!
--  autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup end

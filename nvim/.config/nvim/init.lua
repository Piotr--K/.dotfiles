    yaml = {
      schemas = {
        ["https://json.schemastore.org/openapi-3.0.json"] = "*.yaml",
      },
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
    },
require('user')
require('settings')
require('keymaps')
-- Ctr-p will show current file path
vim.api.nvim_set_keymap('n', '<C-p>', ":echo expand('%:p')<CR>", {noremap = true, silent = true})
-- toggle whitespace display
vim.api.nvim_set_keymap('n', '<F5>', ':set list!<CR>', { noremap = true, silent = true })

-- recompile whenever packer file is modified
-- consider using PackerCompile rather than PackerSync
-- augroup packer_user_config
--  autocmd!
--  autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup end

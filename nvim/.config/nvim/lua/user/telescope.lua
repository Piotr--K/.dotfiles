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

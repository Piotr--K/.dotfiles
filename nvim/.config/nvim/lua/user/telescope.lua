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
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'  -- This is the default. Replace with '--case-sensitive' for case sensitivity.
    },
    path_display = { truncate = 3 }
  },
}

-- pcall(require('telescope').load_extension, 'metals')
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- keymapping for undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- require('telescope.builtin').find_files{ path_display = { "truncate" }}
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sp', function()
  -- Search in project - using live_grep instead of Ack for better integration
  require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').man_pages, { desc = '[S]earch [M]anual' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[P]revious [P]icker' })
-- Removed duplicate: <leader><space> already maps to buffers

-- Document symbols mapping moved to LSP config where it belongs
--git
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>gbc', require('telescope.builtin').git_bcommits, { desc = '[G]it buffer [C]ommits' })

-- nvim-tree
vim.keymap.set('n', '<leader>xx', require('nvim-tree.api').tree.toggle)
-- default keymappings here: https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
-- prettier/formatter keymap
vim.keymap.set('n', '<leader>fp', ':Format<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
-- remap for allowing multiple paste/replace
vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('n', '*', '*zz', {desc = 'Search and center the screen'})
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- move text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- toggleterm
vim.keymap.set('n', '<leader>g', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { desc = 'Toggle Lazygit', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Toggle floating terminal', noremap = true, silent = true })
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm size=10 direction=horizontal<CR>', { desc = 'Toggle horizontal terminal', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Toggle vertical terminal', noremap = true, silent = true })

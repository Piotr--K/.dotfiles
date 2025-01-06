local neogit = require('neogit')

neogit.setup {
  integrations = {
    diffview = true,
    telescope = true,
  },
}

vim.keymap.set("n", "<leader>gm", ":!git mergetool<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gdo", ":DiffviewOpen<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gdc", ":DiffviewClose<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gs", neogit.open,
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gl", ":Neogit log<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gB", ":G blame<CR>",
  {silent = true, noremap = true}
)

local neogit = require('neogit')

neogit.setup {
  integrations = {
    diffview = true,
    telescope = true,
  },
}

vim.keymap.set("n", "<leader>gM", ":Neogit merge<CR>",
  { desc = "Git merge (Neogit)", silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gdo", ":DiffviewOpen<CR>",
  { desc = "Diffview open", silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gdc", ":DiffviewClose<CR>",
  { desc = "Diffview close", silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gs", neogit.open,
  { desc = "Git status (Neogit)", silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gl", ":Neogit log<CR>",
  { desc = "Git log (Neogit)", silent = true, noremap = true}
)
-- Fixed conflict: was <leader>gc, now <leader>gC to avoid clash with telescope git commits
vim.keymap.set("n", "<leader>gC", ":Neogit commit<CR>",
  { desc = "Git commit (Neogit)", silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>",
  { desc = "Git pull (Neogit)", silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>",
  { desc = "Git push (Neogit)", silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>",
  { desc = "Git branches (Telescope)", silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gB", ":G blame<CR>",
  { desc = "Git blame", silent = true, noremap = true}
)

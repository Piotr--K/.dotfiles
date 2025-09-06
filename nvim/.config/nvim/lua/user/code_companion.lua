-- CodeCompanion keymaps (configuration is in lazy-plugins.lua)

vim.keymap.set("n", "<leader>ac", ":CodeCompanionChat Toggle<CR>", { desc = "Toggle CodeCompanion Chat" })
vim.keymap.set("n", "<leader>ab", ":CodeCompanion #buffer ", { desc = "CodeCompanion #buffer", silent = false })
vim.keymap.set("n", "<leader>au", ":CodeCompanion #cursor ", { desc = "CodeCompanion #cursor", silent = false })
vim.keymap.set("n", "<leader>ae", ":CodeCompanion @editor ", { desc = "CodeCompanion @editor", silent = false })
vim.keymap.set("n", "<leader>aa", ":CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
vim.keymap.set("v", "<leader>af", ":CodeCompanion /fix<CR>", { desc = "Fix selected code with CodeCompanion" })
vim.keymap.set("v", "<leader>at", ":CodeCompanion /tests<CR>", { desc = "Generate tests for selected code" })

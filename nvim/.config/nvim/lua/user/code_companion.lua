-- adding extensions (atm mcphub, but there are other as well available
-- require("codecompanion").setup({
--   extensions = {
--     mcphub = {
--       callback = "mcphub.extensions.codecompanion",
--       opts = {
--         make_vars = true,       
--         make_slash_commands = true,
--         show_result_in_chat = true  
--       }
--     }
--   },
  -- you can override default ones like:
  -- defaults are copilot
  -- full list of options: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua#L42-L392
  -- strategies = {
  --   chat = {
  --     adapter = "anthropic",
  --   },
  --   inline = {
  --     adapter = "copilot",
  --   },
  --   cmd = {
  --     adapter = "deepseek",
  --   }
  -- }
  -- key bindings: https://codecompanion.olimorris.dev/configuration/inline-assistant.html
-- })

vim.keymap.set("n", "<leader>ac", ":CodeCompanionChat Toggle<CR>", { desc = "Toggle CodeCompanion Chat" })
vim.keymap.set("n", "<leader>ab", ":CodeCompanion #buffer ", { desc = "CodeCompanion #buffer", silent = false })
vim.keymap.set("n", "<leader>au", ":CodeCompanion #cursor ", { desc = "CodeCompanion #cursor", silent = false })
vim.keymap.set("n", "<leader>ae", ":CodeCompanion @editor ", { desc = "CodeCompanion @editor", silent = false })
vim.keymap.set("n", "<leader>aa", ":CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
vim.keymap.set("v", "<leader>af", ":CodeCompanion /fix<CR>", { desc = "Fix selected code with CodeCompanion" })
vim.keymap.set("v", "<leader>at", ":CodeCompanion /tests<CR>", { desc = "Generate tests for selected code" })

-- adding extensions (atm mcphub, but there are other as well available
require("codecompanion").setup({
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = true,       
        make_slash_commands = true,
        show_result_in_chat = true  
      }
    }
  },
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
})

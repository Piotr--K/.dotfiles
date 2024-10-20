require('iron.core').setup({
  config = {
    repl_definition = {
      javascript = {
        -- Configure Iron to use the default Node.js REPL
        command = {"node"}
      },
      haskell = {
        command = {"ghci"}
        -- command = function(meta)
        --   local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
        --   return { 'cabal', 'v2-repl', filename}
        -- end
      }
    },
    -- Enable Iron to work in a more visual way with Neovim buffers
    repl_open_cmd = "vsplit" -- This will open the REPL in a vertical split
  },
  keymaps = {
    send_motion = "<leader>ssc",  -- Send the current motion to the REPL
    visual_send = "<leader>ssc",  -- Send the visually selected text
    send_file = "<leader>ssf",    -- Send the entire file to the REPL
    send_line = "<leader>ssl",    -- Send the current line to the REPL
    send_mark = "<leader>ssm",    -- Send a specific mark to the REPL
    cr = "<leader>ss<cr>",        -- Send the line and move to the next one
    interrupt = "<leader>ss<space>", -- Interrupt the REPL
    exit = "<leader>ssq",         -- Exit the REPL
  }
})


local M = {
  filetype = {
    javascript = {
      require("formatter.filetypes.javascript").prettier
    },
    typescript = {
      require("formatter.filetypes.typescript").prettier
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whites
    },
  }
}

-- this auto format doesn't work for some reason
-- maybe because linters have also autocmd defined?
-- TODO: im not sure i like autoformat anyway
-- for now i will format using some key binding to :Format
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  command = "FormatWriteLock"
})

return M

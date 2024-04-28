-- at the moment just eslint
-- but with plugin below i can use other available linters
-- https://github.com/mfussenegger/nvim-lint
require('lint').linters_by_ft = {
  javascript = {'eslint'},  -- For JavaScript files
  typescript = {'eslint'},  -- If you're using TypeScript
  javascriptreact = {'eslint'},  -- For React JS files
  typescriptreact = {'eslint'},  -- For React TS files
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

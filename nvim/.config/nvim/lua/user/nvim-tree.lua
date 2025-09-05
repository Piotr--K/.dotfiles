require("nvim-tree").setup({
  diagnostics = {
    enable = true,
-- Icons configuration - using defaults which work well with nvim-web-devicons
  },
  view = {
    width = 30,
  },
  update_focused_file = {
    enable = true
  },
  filters = {
    dotfiles = false,
  },

})
-- require("nvim-tree").setup({
--   sort_by = "case_sensitive",
--   view = {
--     width = 30,
--     mappings = {
--       list = {
--         { key = "u", action = "dir_up" },
--       },
--     },
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })

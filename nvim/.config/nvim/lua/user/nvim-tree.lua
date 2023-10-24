require("nvim-tree").setup({
  diagnostics = {
    enable = true,
-- TODO: setup icons for hint/info/warning/error if defaults don't work
  },
  view = {
    width = 30,
  },
  update_focused_file = {
    enable = true
  }

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

local M = {}
M.config = function()
    event = { "BufReadPre", "BufNewFile" }
    local conform = require("conform")
    local format_on_save_enabled = true
      
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier", "eslint_d" },
        typescript = { "prettier", "eslint_d" },
      },
      -- format_on_save = {
        -- lsp_fallback = true,
        -- async = false,
        -- timeout_ms = 500,
      -- },
    })
  
    function ToggleFormatOnSave()
      format_on_save_enabled = not format_on_save_enabled
      
      if format_on_save_enabled then
        print("Auto-format on save enabled")
      else
        print("Auto-format on save disabled")
      end
    end

    vim.api.nvim_create_autocmd({"BufWritePre"}, {
      callback = function()
        if format_on_save_enabled then
          conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
          })
        end
      end
    })

    -- Keybinding to manually toggle auto-formatting on/off
    vim.keymap.set("n", "<leader>tf", ToggleFormatOnSave, { desc = "Toggle format on save" })

    vim.keymap.set({ "n", "v" }, "<leader>pp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end
return M



  -- TODO: this used to be
  -- also i'm following different styles, eg. here i'm referrencing
  -- plugin - which i haven't done before
  -- get comfy with one of the styles
  -- filetype = {
  --   javascript = {
  --     require("formatter.filetypes.javascript").prettier
  --   },
  --   typescript = {
  --     require("formatter.filetypes.typescript").prettier
  --   },
  --   ["*"] = {
  --     require("formatter.filetypes.any").remove_trailing_whites
  --   },
  -- }


-- this auto format doesn't work for some reason
-- maybe because linters have also autocmd defined?
-- TODO: im not sure i like autoformat anyway
-- for now i will format using some key binding to :Format
--[[ vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   command = "FormatWriteLock"
-- }) ]]

-- return M

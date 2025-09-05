local M = {}
M.config = function()
    event = { "BufReadPre", "BufNewFile" }
    local conform = require("conform")
    local format_on_save_enabled = true
      
    -- conform will run first available formatter
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        scala = { "scalafmt" },
        go = { "goimports", "gofmt" },
        -- install cljfmt with:
        -- clojure -Sdeps '{:deps {cljfmt/cljfmt {:mvn/version "0.8.2"}}}' -m cljfmt.main
        clojure = { "cljfmt" },
        javascript = { "eslint_d", "prettier", stop_after_first = true  },
        typescript = { "eslint_d", "prettier", stop_after_first = true  },
      },
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
    vim.keymap.set("n", "<leader>fs", ToggleFormatOnSave, { desc = "Toggle format on save" })

    vim.keymap.set({ "n", "v" }, "<leader>pp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end
return M



  -- Note: Removed old formatter.nvim and prettier.nvim configurations
  -- Now using only conform.nvim for better performance and maintenance


-- Auto-format on save is now properly implemented above
-- Removed old formatter.nvim autocmd as it was causing conflicts

-- return M

return function(use)
	use({
		"guns/vim-sexp",
		"tpope/vim-sexp-mappings-for-regular-people",
		"luochen1990/rainbow",
		"Olical/conjure",
		"radenling/vim-dispatch-neovim",
		"clojure-vim/vim-jack-in",
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
		require('cmp').setup {
			sources = {
				{ name = 'conjure' },
			}
		}
	})
end

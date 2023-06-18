return function(use)
	use({
		"guns/vim-sexp",
		"tpope/vim-sexp-mappings-for-regular-people",
		--TODO: i've disabled it temp as it didnt work for me
		--ive configured nvim-ts-rainbow to try out
		--thats using treesitter
		-- "luochen1990/rainbow",
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
		},
		-- vim.keymap.set('n', '<leader>|', "<Plug>('sexp_convolute')", { silent = true }),
		-- vim.api.nvim_del_keymap('n', "<Plug>('sexp_convolute')")
-- vim.api.nvim_del_keymap('n', '<leader>?')
		-- g.sexp_mappings {
		--  	sexp_convolute = ''
		--  }
	})
end

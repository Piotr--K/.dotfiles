function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- todo - remove this, doesn't do anything
map('n', '<leader>|', "<Plug>('sexp_convolute')", { silent = true })
-- nunmap '<leader>?'
-- vim.api.nvim_del_keymap('n', '<leader>?')

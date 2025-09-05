  require('rose-pine').setup({
    --- @usage 'auto'|'main'|'moon'|'dawn'
    variant = 'auto',
    --- @usage 'main'|'moon'|'dawn'
    dark_variant = 'main',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,
    --- @usage string hex value or named color from rosepinetheme.com/palette
    groups = {
	background = 'base',
		background_nc = '_experimental_nc',
		panel = 'surface',
		panel_nc = 'base',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
    },
     highlight_groups = {
       -- those 3 lines were added while refactoring
       ColorColumn = { bg = 'rose' },
       StatusLine = { fg = 'love', bg = 'love', blend = 10 },
       Search = { bg = 'gold', inherit = false },

       -- CursorLine = { fg='highlight_high', bg = 'surface', blend = 10}, -- cursor color
       CursorLine = { fg='love', bg = 'surface', blend = 10}, -- cursor color
       CursorLineNr = { fg = 'love', bg = 'surface', bold = false },
     }
   })
  -- Set colorscheme after options
  vim.cmd('colorscheme rose-pine')
  vim.opt.cursorline = true

local dap = require('dap')
local dapui = require('dapui')
dapui.setup()

vim.keymap.set('n', '<F5>', function() require('dap').continue() end, {noremap = true, silent = true})
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- conditional breakpoint, where:
-- first arg passed needs to be a boolean condition
-- and second argument needs to be a number indicating how many times line needs to be hit before execution pauses on the breakpoint
vim.keymap.set('n', '<leader>bc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '), vim.fn.input('Hit count: '), nil) end)
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<leader>dc', function() require('dap').repl.close() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>dx', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<leader>da', function() require('dap').list_breakpoints() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)

--ui key bindings
vim.keymap.set('n', '<leader>duo', function() dapui.open() end)
vim.keymap.set('n', '<leader>duc', function() dapui.close() end)
vim.keymap.set('n', '<leader>dut', function() dapui.toggle() end)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
---

-- client
dap.defaults.fallback.terminal_win_cmd = 'belowright new'

local function configure_debuggers()
	require("user.dap.scala").setup()
	require("user.dap.go").setup()
	require("user.dap.typescript").setup()
	require("user.dap.javascript").setup()
end

configure_debuggers()

local M = {}

local DEBUGGER_PATH = vim.fn.stdpath "data" .. "/site/pack/packer/opt/vscode-js-debug"

function M.setup()
  local dap = require "dap"

  -- Use the same adapter as JavaScript
  require("dap-vscode-js").setup {
    node_path = "node",
    debugger_path = DEBUGGER_PATH,
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
  }

  -- JavaScript configurations are now handled in javascript.lua

  dap.configurations.typescript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Docker",
      address = "0.0.0.0",
      port = 21000,
      remoteRoot = "/app/",
      localRoot = "${workspaceFolder}",
      protocol = "inspector",
      sourceMaps = true,
      skipFiles = {"<node_internals>/**"},
      restart = true,
      continueOnAttach = true,
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Process",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    }
  }

  dap.configurations.typescriptreact = {
    {
      type = "pwa-chrome",
      name = "Launch Chrome",
      request = "launch",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
    },
  }
end

return M

local DEBUGGER_PATH = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"

local M = {}

-- TODO: move to telescope so it could be used 
-- by other configurations
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local function pick_process(callback)
    pickers.new({}, {
        prompt_title = "Select a Node.js process",
        finder = finders.new_oneshot_job({"ps", "axco", "pid,command"}, {cwd = "/"}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                local pid = selection.value:match("^(%d+)")
                callback(pid)
            end)
            return true
        end
    }):find()
end

local function pick_docker_container(callback)
    pickers.new({}, {
        prompt_title = "Select a Docker Container",
        finder = finders.new_oneshot_job({'docker', 'ps', '--format', '{{.ID}} {{.Names}}'}, {cwd = "/"}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                local container_id = selection.value:match("^%S+")
                callback(container_id)
            end)
            return true
        end
    }):find()
end

function M.setup()
  -- local dap = require "dap"

  -- dap.adapters.node2 = {
  --   type = "executable",
  --   command = "node",
  --   agrs = DEBUGGER_PATH,
  --   -- args = {os.getenv('HOME') .. '/.config/nvim/debuggers/vscode-node-debug2/out/src/nodeDebug.js'}, -- Adjust the path as necessary
  -- }

  require("dap-vscode-js").setup {
    node_path = "node",
    debugger_path = DEBUGGER_PATH,
    -- debugger_cmd = { "js-debug-adapter" },
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
  }

  -- require("dap-vscode-js").adapters.node = {
  --   type = 'executable',
  --   command = 'node',
  --   args = {os.getenv('HOME') .. '/.config/nvim/debuggers/vscode-node-debug2/out/src/nodeDebug.js'}, -- Adjust the path as necessary
  -- }

  for _, language in ipairs { "typescript", "javascript" } do
    require("dap").configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      -- {
      --   type = "node2",
      --   request = "attach",
      --   name = "Attach To Docker PK",
      --   protocol = 'inspector',
      --   localRoot = vim.fn.getcwd(),
      --   remoteRoot = '/app', -- Same as VSCode's remoteRoot
      --   port = 20800, -- Typical Node.js debug port, adjust if your setup differs
      --   sourceMaps = true,
      --   skipFiles = {'<node_internals>/**'},
      --   program = "${file}",
      --   cwd = "${workspaceFolder}",
      -- },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process with filter",
        processId = function(callback)
          pick_docker_container(function(pid)
            callback(pid)
          end)
        end,
        protocol = "inspector",
        port = 20800,
        cwd = "${workspaceFolder}",
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach to Docker',
        -- platform = 'node',
        address = '0.0.0.0',
        -- hostname = 'localhost',   -- Use 'localhost' if you map the port to the host
        port = 20207,             -- The port you exposed and mapped in docker-compose
        -- 20207: transaction-cache
        remoteRoot = '/app/',      -- Adjust this to the working directory in the container
        -- localRoot = vim.fn.getcwd(),
        localRoot = '${workspaceFolder}',
        -- cwd = '${workspaceFolder}',  -- Adjust this to your local project directory
        -- protocol = 'inspector',
        -- sourceMaps = true,
          -- protocol = 'inspector',
        -- skipFiles = {'<node_internals>/**'},
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      {
        -- This configuration is useful for debugging npm scripts
        name = 'Debug npm test',
        type = 'pwa-node',
        request = 'launch',
        runtimeExecutable = 'npm',
        runtimeArgs = {
          'run-script', 
          'localDev'}, -- Replace 'debug' with your script's name
        rootPath = "${workspaceFolder}",
        cwd = vim.fn.getcwd(),
        protocol = 'inspector',
        console = 'integratedTerminal',
        internalConsoleOptions = "neverOpen",
      }
    }
  end

  -- for _, language in ipairs { "typescriptreact", "javascriptreact" } do
  --   require("dap").configurations[language] = {
  --     {
  --       type = "pwa-chrome",
  --       name = "Attach - Remote Debugging",
  --       request = "attach",
  --       program = "${file}",
  --       cwd = vim.fn.getcwd(),
  --       sourceMaps = true,
  --       protocol = "inspector",
  --       port = 9222,
  --       webRoot = "${workspaceFolder}",
  --     },
  --     {
  --       type = "pwa-chrome",
  --       name = "Launch Chrome",
  --       request = "launch",
  --       url = "http://localhost:3000",
  --     },
  --   }
  -- end
end

return M

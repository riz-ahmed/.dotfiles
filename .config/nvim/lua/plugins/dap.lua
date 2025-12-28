return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Load launch.json after DAP is initialized

      local dap = require("dap")
      -- Register cppdbg adapter
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7", -- Update this path
        options = {
          detached = false,
        },
      }

      -- Setup vscode extension with json decoder
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      -- Load launch.json from .vscode directory
      vscode.load_launchjs()
    end,
  },
}

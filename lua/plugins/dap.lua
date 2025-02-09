return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- UI for debugging
      "theHamsta/nvim-dap-virtual-text", -- Inline debug info
      "jay-babu/mason-nvim-dap.nvim", -- Auto-install debuggers
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Ensure UI opens on debugging
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Setup GDB for C++
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7", -- C++ Debug Adapter
      }

      dap.configurations.cpp = {
        {
          name = "Launch C++ Program",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "Enable GDB pretty printing",
              ignoreFailures = false,
            },
          },
        },
      }

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}

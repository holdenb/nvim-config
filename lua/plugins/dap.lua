return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- "rcarriga/nvim-dap-ui",
      -- "theHamsta/nvim-dap-virtual-text",
      -- "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      -- local dapui = require("dapui")

      --   dapui.open()
      -- end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end

      -- dap.adapters.cppdbg = {
      --   id = "cppdbg",
      --   type = "executable",
      --   command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
      --   options = {
      --     detached = false,
      --   },
      -- }

      -- dap.configurations.cpp = {
      --   {
      --     name = "Attach to gdbserver",
      --     type = "cppdbg",
      --     request = "attach",
      --     target = "localhost:4444",
      --     program = function()
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --     end,
      --     cwd = "${workspaceFolder}",
      --     MIMode = "gdb",
      --     setupCommands = {
      --       { text = "-gdb-set target-async on", ignoreFailures = false },
      --       { text = "-gdb-set auto-solib-add on", ignoreFailures = false },
      --       { text = "-gdb-set print pretty on", ignoreFailures = false },
      --     },
      --     attachTimeout = 100000,
      --     externalConsole = false,
      --   },
      -- }

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=mi" },
        options = {
          initialize_timeout_sec = 100,
        },
      }

      -- dap.configurations.cpp = {
      --   {
      --     name = "Attach to gdbserver",
      --     type = "gdb",
      --     request = "attach",
      --     target = "localhost:4444",
      --     program = function()
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --     end,
      --     cwd = "${workspaceFolder}",
      --   },
      -- }

      dap.configurations.cpp = {
        {
          name = "Attach to running process",
          type = "cppdbg",
          request = "attach",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          processId = function()
            return tonumber(vim.fn.input("Process ID: "))
          end,
          cwd = "${workspaceFolder}",
          MIMode = "gdb",
          stopOnEntry = false,
          setupCommands = {
            { text = "-gdb-set target-async on", ignoreFailures = false },
            { text = "-gdb-set auto-solib-add on", ignoreFailures = false },
            { text = "-gdb-set print pretty on", ignoreFailures = false },
            { text = "-gdb-set non-stop on", ignoreFailures = false },
            { text = "-gdb-set detach-on-fork off", ignoreFailures = false },
          },
        },
      }

      -- dap.adapters.gdb = {
      --   type = "executable",
      --   command = "gdb",
      --   -- Use mi2 (machine interface 2) because gdb does not natively support dap
      --   args = { "--interpreter=mi2", "--eval-command", "set print pretty on" },
      --   options = {
      --     initialize_timeout_sec = 5,
      --   },
      -- }
      --
      -- dap.configurations.cpp = {
      --   {
      --     name = "Launch",
      --     type = "gdb",
      --     request = "launch",
      --     program = function()
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --     end,
      --     cwd = "${workspaceFolder}",
      --     stopAtBeginningOfMainSubprogram = false,
      --   },
      --   {
      --     name = "Select and attach to process",
      --     type = "gdb",
      --     request = "attach",
      --     program = function()
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --     end,
      --     pid = function()
      --       local name = vim.fn.input("Executable name (filter): ")
      --       return require("dap.utils").pick_process({ filter = name })
      --     end,
      --     cwd = "${workspaceFolder}",
      --   },
      --   {
      --     name = "Attach to gdbserver :4444",
      --     type = "gdb",
      --     request = "attach",
      --     target = "localhost:4444",
      --     program = function()
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --     end,
      --     cwd = "${workspaceFolder}",
      --     stopOnEntry = false,
      --     setupCommands = {
      --       { text = "-gdb-set target-async on", ignoreFailures = false },
      --       { text = "-gdb-set auto-solib-add on", ignoreFailures = false },
      --       { text = "-gdb-set print pretty on", ignoreFailures = false },
      --       { text = "-gdb-set non-stop on", ignoreFailures = false },
      --       { text = "-gdb-set detach-on-fork off", ignoreFailures = false },
      --     },
      --   },
      -- }

      -- require("dapui").setup()
      -- require("nvim-dap-virtual-text").setup({
      --   enabled = true,
      --   enabled_commands = false,
      --   highlight_changed_variables = true,
      --   show_stop_reason = true,
      -- })
    end,
  },
}

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    }

    dap.configurations.cpp = {
      {
        name = "Attach to gdbserver with correct source mapping",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to binary: ", vim.fn.getcwd() .. "TODO", "file")
        end,
        cwd = "${workspaceFolder}",
        MIMode = "gdb",
        miDebuggerPath = "/usr/bin/gdb",
        miDebuggerServerAddress = "127.0.0.1:1234",
        stopAtEntry = false,
        sourceFileMap = {
          ["/checkout/src"] = "TODO",
        },
        setupCommands = {
          {
            description = "Ignore SIGSEGV",
            text = "handle SIGSEGV nostop noprint pass",
          },
          {
            description = "Ignore SIGABRT",
            text = "handle SIGABRT nostop noprint pass",
          },
          {
            description = "Ignore SIGFPE",
            text = "handle SIGFPE nostop noprint pass",
          },
          {
            description = "Ignore SIGILL",
            text = "handle SIGILL nostop noprint pass",
          },
          {
            description = "Ignore SIGBUS",
            text = "handle SIGBUS nostop noprint pass",
          },
        },
      },
    }

    dap.configurations.c = dap.configurations.cpp
  end,
}

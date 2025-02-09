return {
  {
    "folke/which-key.nvim",
    vscode = true, -- only load in VSCode
    opts = {
      -- custom config
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- Less aggressive type checking
                autoImportCompletions = true,
                diagnosticMode = "openFilesOnly", -- Only check open files (not the entire project)
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {
          settings = {
            lint = true, -- Enable linting
            organizeImports = true, -- Sort imports automatically
          },
        },
      },
      format = {
        format_on_save = true, -- Enable auto-formatting
      },
    },
  },
}

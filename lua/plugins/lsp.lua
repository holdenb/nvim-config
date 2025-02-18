return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = {
        format_on_save = true, -- Enable auto-formatting
      },
      servers = {
        pyright = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
        bufls = {
          cmd = { "buf", "beta", "lsp", "--timeout=0", "--log-format=text" },
          filetypes = { "proto" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("buf.yaml", ".git")(fname)
          end,
        },
        bashls = {},
        clangd = {
          capabilities = (function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.offsetEncoding = { "utf-8" }
            return capabilities
          end)(),
          on_attach = function(client, bufnr)
            require("clangd_extensions").setup()
          end,
          cmd = {
            vim.fn.stdpath("data") .. "/mason/bin/clangd",
            "--offset-encoding=utf-8",
            "--background-index", -- Enable background indexing
            "--clang-tidy", -- Enable Clang-Tidy checks
            "--suggest-missing-includes", -- Suggest missing headers
            "--header-insertion=never", -- Avoid unwanted header insertion
            "--log=error", -- Reduce logging noise
            "--completion-style=detailed", -- Show detailed completion items
            "--pch-storage=memory", -- Store precompiled headers in memory for speed
            "--folding-ranges", -- Enable code folding
            "--malloc-trim", -- Reduce memory usage,
          },
        },
      },
    },
  },
}

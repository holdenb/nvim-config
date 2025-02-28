return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = {
        format_on_save = true,
      },
      servers = {
        pyright = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {
          settings = {
            lint = true,
            organizeImports = true,
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
            "--background-index",
            "--clang-tidy",
            "--suggest-missing-includes",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--pch-storage=memory",
            "--folding-ranges",
          },
        },
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
      format = {
        format_on_save = {
          enabled = true,
          ignore_filetypes = { "proto" },
        },
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
          on_attach = function(client, _)
            -- Disable formatting capability
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
        bashls = {},
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp" },
          capabilities = (function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.offsetEncoding = { "utf-8" }
            capabilities.textDocument.completion.snippetSupport = false
            return capabilities
          end)(),
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
        lemminx = {
          filetypes = { "xml", "urdf" },
          settings = {
            xml = {
              server = {
                workDir = ".",
              },
              catalogs = {
                vim.fn.expand("~/.config/lemminx/catalog.xml"),
              },
            },
          },
        },
      },
    },
  },
}

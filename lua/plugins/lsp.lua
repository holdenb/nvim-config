return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          on_attach = function(client, bufnr)
            require("clangd_extensions").setup()
          end,
          cmd = {
            "clangd",
            "--background-index", -- Enable background indexing
            "--clang-tidy", -- Enable Clang-Tidy checks
            "--suggest-missing-includes", -- Suggest missing headers
            "--header-insertion=never", -- Avoid unwanted header insertion
            "--log=error", -- Reduce logging noise
            "--completion-style=detailed", -- Show detailed completion items
            "--pch-storage=memory", -- Store precompiled headers in memory for speed
            "--limit-results=50", -- Limit completion results for performance
            "--folding-ranges", -- Enable code folding
            "--malloc-trim", -- Reduce memory usage,
            "--compile-commands-dir=./build/debug",
          },
        },
        pyright = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        },
      },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "hrsh7th/nvim-cmp" }, -- Ensure it loads after nvim-cmp
    opts = {
      inlay_hints = {
        enabled = true,
      },
    },
  },
}

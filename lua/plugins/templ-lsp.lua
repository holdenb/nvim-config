return {
  { import = "lazyvim.plugins.extras.lang.go" },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = { ensure_installed = { "gopls", "templ" } }, -- templ is recognized by Mason ≥ v1.11
  },

  -- 4-B ▸ Actual server setup
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          settings = {
            gopls = {
              -- let gopls understand generated .templ code
              templateExtensions = { "templ" },
            },
          },
        },

        templ = {
          cmd = { "templ", "lsp" },
          filetypes = { "templ" },
          root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
        },
      },
    },
  },
}

-- Register .templ as a valid filetype
vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

return {
  { import = "lazyvim.plugins.extras.lang.go" },

  -- Requirements
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "gopls", "templ" } },
  },

  -- LSP Cofig
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

  -- Treesitter Config
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure opts.ensure_installed exists
      if not opts.ensure_installed then
        opts.ensure_installed = {}
      end

      -- Add templ parser if not already present
      local has_templ = false
      for _, lang in ipairs(opts.ensure_installed) do
        if lang == "templ" then
          has_templ = true
          break
        end
      end

      if not has_templ then
        vim.list_extend(opts.ensure_installed, { "templ" })
      end

      return opts
    end,
  },
}

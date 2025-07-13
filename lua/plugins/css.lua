return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
        stylelint_lsp = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "css" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      local css_lint = { "stylelint" }
      for _, ft in ipairs({ "css", "scss", "less" }) do
        opts.linters_by_ft[ft] = css_lint
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local css_fmt = { "prettier" }
      for _, ft in ipairs({ "css", "scss", "less" }) do
        opts.formatters_by_ft[ft] = css_fmt
      end
    end,
  },
}

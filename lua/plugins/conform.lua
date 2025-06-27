return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cpp = { "clang-format" },
      c = { "clang-format" },
      lua = { "stylua" },
      python = { "black", "ruff" },
      go = { "gofmt" },
      xml = { "xmlformatter" },
    },
    formatters = {
      xmlformatter = {
        command = "xmlformat",
        args = { "--indent", "4" },
        stdin = true,
      },
    },
  },
}

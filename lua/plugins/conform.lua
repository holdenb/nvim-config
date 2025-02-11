return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cpp = { "clang-format" }, -- Force clang-format for C++
      c = { "clang-format" },
    },
  },
}

-- Register the language
vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed or {}, { "templ" }) -- parser from vrischmann/tree-sitter-templ
  end,
}

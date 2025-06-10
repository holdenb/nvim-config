if vim.g.vscode then
  require("user.vscode_keymaps")
else
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

vim.filetype.add({
  extension = {
    urdf = "xml",
    [".*%.xml%..+"] = "xml",
  },
})

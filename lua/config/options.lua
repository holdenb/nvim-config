-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.g.vscode then
  require("user.vscode_keymaps")
else
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

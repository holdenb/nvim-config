-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Create a group just to keep things organized (optional).
local group = vim.api.nvim_create_augroup("waf_python", { clear = true })

-- Whenever we open a file named `wscript` or `waf`, set filetype=python.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "wscript", "waf" },
  callback = function()
    vim.bo.filetype = "python"
  end,
  group = group,
})

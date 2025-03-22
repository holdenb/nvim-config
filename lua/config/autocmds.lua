-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local py_waf_group = vim.api.nvim_create_augroup("waf_python", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "wscript", "waf" },
  callback = function()
    vim.bo.filetype = "python"
  end,
  group = py_waf_group,
})

local xml_urdf_group = vim.api.nvim_create_augroup("urdf_xml", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "urdf", ".*%.xml%..+" },
  callback = function()
    vim.bo.filetype = "xml"
  end,
  group = xml_urdf_group,
})

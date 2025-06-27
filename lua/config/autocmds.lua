local py_waf_group = vim.api.nvim_create_augroup("waf_python", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "wscript", "wscript_build", "waf" },
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

-- vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
--   pattern = { "*" },
--   command = "silent! wall",
--   nested = true,
-- })

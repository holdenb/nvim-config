-- return {
--   {
--     "benlubas/molten-nvim",
--     version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
--     dependencies = { "3rd/image.nvim" },
--     build = ":UpdateRemotePlugins",
--     init = function()
--       vim.g.molten_image_provider = "image.nvim"
--       vim.g.molten_output_win_max_height = 20
--     end,
--   },
--   {
--     -- see the image.nvim readme for more information about configuring this plugin
--     "3rd/image.nvim",
--     opts = {
--       backend = "kitty", -- whatever backend you would like to use
--       max_width = 100,
--       max_height = 12,
--       max_height_window_percentage = math.huge,
--       max_width_window_percentage = math.huge,
--       window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
--       window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
--     },
--   },
-- }

return {
  "benlubas/molten-nvim",
  version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  build = ":UpdateRemotePlugins",
  dependencies = { "3rd/image.nvim" },
  ft = { "python", "markdown", "quarto" },
  config = function()
    -- Molten basic settings
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = true
    vim.g.molten_image_provider = "external" -- important for Warp

    -- Auto-detect kernel when opening .ipynb
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "*.ipynb",
      callback = function()
        -- Inline the auto kernel logic (no need for external file if you prefer)
        local filename = vim.api.nvim_buf_get_name(0)
        if not filename:match("%.ipynb$") then
          return
        end

        local ok, json = pcall(vim.fn.json_decode, vim.fn.readfile(filename))
        if not ok then
          vim.notify("Molten: Could not decode ipynb JSON", vim.log.levels.ERROR)
          return
        end

        local kernel = json.metadata and json.metadata.kernelspec and json.metadata.kernelspec.name
        if kernel then
          vim.cmd("MoltenInit kernel=" .. kernel)
          vim.notify("Molten: Auto-started kernel '" .. kernel .. "'", vim.log.levels.INFO)
        else
          vim.notify("Molten: No kernelspec found, running default MoltenInit", vim.log.levels.WARN)
          vim.cmd("MoltenInit")
        end
      end,
    })
  end,
}

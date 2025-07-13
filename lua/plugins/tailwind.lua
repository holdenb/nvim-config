return {
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { tailwindcss = {} } },
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    opts = { color_square_width = 2 },
    dependencies = { "hrsh7th/nvim-cmp" },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = { user_default_options = { tailwind = true } },
  },
}

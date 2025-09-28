return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        "python",
        "markdown",
        "markdown_inline",
        "latex",
        "json",
        "yaml",
        "bash",
      })
    end,
  },

  -- LaTeX: syntax + conceal + motions
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "zathura"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex" },
        callback = function()
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nc"
        end,
      })
    end,
  },

  -- Prettier Markdown (headings, tables, fenced blocks, math conceal)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
      -- sensible defaults; works without extra deps
      file_types = { "markdown" },
    },
  },

  -- Rainbow parens / brackets
  { "HiPhish/rainbow-delimiters.nvim" },

  -- Smarter match highlighting & motions
  { "andymass/vim-matchup" },

  -- TODO / FIXME highlighting in code & notes
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Quality-of-life for Python “# %%” cells: highlight + motions
  {
    "nvim-lua/plenary.nvim", -- just for safety in case you use it elsewhere
    init = function()
      -- Highlight cell separators
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python" },
        callback = function()
          vim.cmd([[syntax match JupyterCell /^#\s*%%.*$/]])
          vim.cmd([[highlight link JupyterCell Title]])
          -- simple motions between cells
          vim.keymap.set("n", "]c", [[/^\s*#\s*%%<CR>]], { buffer = true, desc = "Next cell" })
          vim.keymap.set("n", "[c", [[?^\s*#\s*%%<CR>]], { buffer = true, desc = "Prev cell" })
        end,
      })
    end,
  },
}

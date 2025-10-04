-- Run current cell (no reliance on <Space>x)
local function jupy_run_current_cell()
  -- select inside current cell, then execute
  vim.cmd("normal! vij")
  vim.cmd("JupyniumExecuteSelectedCells")
  -- leave visual mode where you were
  vim.cmd("normal! gv") -- optional: keep selection; remove if you don't want it
end

-- Run current + move to next cell
local function jupy_run_and_next()
  vim.cmd("normal! vij")
  vim.cmd("JupyniumExecuteSelectedCells")
  vim.cmd("normal! ]j") -- jump to next cell separator
end

return {
  {
    "kiyoon/jupynium.nvim",
    cmd = {
      "JupyniumStartAndAttachToServer",
      "JupyniumStartSync",
      "JupyniumStopSync",
      "JupyniumKernelSelect",
      "JupyniumDownloadIpynb",
      "JupyniumScrollToCell",
      "JupyniumLoadFromIpynbTab",
      "JupyniumKernelOpenInTerminal",
    },
    init = function()
      vim.env.FIREFOX_BIN = nil
      vim.env.MOZ_FIREFOX_BIN = nil
      vim.env.MOZ_FIREFOX_PATH = nil
    end,
    keys = function()
      return {
        { "<leader>js", "<cmd>JupyniumStartAndAttachToServer<cr>", desc = "Start & attach" },
        { "<leader>jy", "<cmd>JupyniumStartSync<cr>", desc = "Start sync" },
        { "<leader>jY", "<cmd>JupyniumStopSync<cr>", desc = "Stop sync" },
        { "<leader>jk", "<cmd>JupyniumKernelSelect<cr>", desc = "Select kernel" },
        { "<leader>jd", "<cmd>JupyniumDownloadIpynb<cr>", desc = "Download .ipynb" },
        { "]c", [[/^\s*#\s*%%\s*\(\[markdown\]\)\?$\r]], desc = "Next cell", mode = "n" },
        { "[c", [[?^\s*#\s*%%\s*\(\[markdown\]\)\?$\r]], desc = "Prev cell", mode = "n" },

        -- New execution maps
        { "<leader>xx", jupy_run_current_cell, desc = "Run current cell" },
        { "<leader>xj", jupy_run_and_next, desc = "Run cell & jump next" },
        { "<leader>xX", "<cmd>JupyniumExecuteSelectedCells<cr>", desc = "Execute selected cells" },
      }
    end,
    opts = {
      jupyter_command = "jupyter",
      default_notebook_URL = "localhost:8888/nbclassic",
      -- use_default_keybinds = false,
    },
  },

  -- Markdown: pretty rendering toggle + cell helpers
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = { file_types = { "markdown" } },
    keys = {
      -- Toggle pretty rendering for Markdown buffers
      {
        "<leader>tm",
        function()
          -- Prefer the plugin command if present; otherwise, fallback to conceal toggle
          if vim.fn.exists(":RenderMarkdown") == 2 then
            vim.cmd("RenderMarkdown toggle")
          else
            local cl = vim.opt_local.conceallevel:get()
            vim.opt_local.conceallevel = (cl == 0) and 2 or 0
          end
        end,
        desc = "Toggle Markdown rendering",
        ft = "markdown",
      },
    },
  },

  -- Vimtex: LaTeX QoL (optional viewer shortcut)
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "zathura"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nc"
        end,
      })
    end,
    keys = {
      { "<leader>lv", "<cmd>VimtexView<cr>", desc = "Vimtex view", ft = "tex" },
      { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "Vimtex compile", ft = "tex" },
    },
  },

  -- Python “# %%” cells: highlight + motions + quick insertors
  {
    "nvim-lua/plenary.nvim",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(ev)
          -- highlight cell headers like '# %%' and '# %% [markdown]'
          vim.cmd([[syntax match JupyterCell /^\s*#\s*%%\_.*/]])
          vim.cmd([[highlight default link JupyterCell Title]])
          -- motions between cells
          vim.keymap.set("n", "]c", [[/^\s*#\s*%%\s*\(\[markdown\]\)\?$\r]], { buffer = ev.buf, desc = "Next cell" })
          vim.keymap.set("n", "[c", [[?^\s*#\s*%%\s*\(\[markdown\]\)\?$\r]], { buffer = ev.buf, desc = "Prev cell" })
          -- quick insert: new code/markdown cell headers
          vim.keymap.set("n", "<leader>cc", "o# %%<Esc>", { buffer = ev.buf, desc = "Insert code cell header" })
          vim.keymap.set(
            "n",
            "<leader>cM",
            "o# %% [markdown]<Esc>",
            { buffer = ev.buf, desc = "Insert markdown cell header" }
          )
        end,
      })
    end,
  },

  -- Extras: rainbow parens + matchup + TODOs
  { "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
  { "andymass/vim-matchup", event = "VeryLazy" },
  { "folke/todo-comments.nvim", opts = {}, event = "VeryLazy" },
}

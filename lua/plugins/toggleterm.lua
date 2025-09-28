-- ----------------------------------------------------------------------------
-- --- Open terminals ---
-- ----------------------
--    <leader>tt    -> floating shell
--    <leader>tv    -> vertical split shell
--    <leader>th    -> horizontal shell
--    <leader>tg    -> lazygit (float)
--    <leader>tb    -> btop (float)
--    <C- >`        -> your persistent floating terminal (#1) in any mode
--
-- --- Inside the terminal ---
-- ---------------------------
--    Esc/jk/kj     -> normal mode
--    Ctrl+h/j/k/l  -> move to splits
--    Ctrl+Q        -> close the terminal window
-- ----------------------------------------------------------------------------
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (float)" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Terminal (vertical)" },
      { "<leader>th", "<cmd>ToggleTerm size=12 direction=horizontal<cr>", desc = "Terminal (horizontal)" },

      -- Persistent floating terminal (#1), usable from Normal & Terminal modes
      {
        "<C-`>",
        function()
          require("toggleterm").toggle(1, 12, vim.loop.cwd(), "float")
        end,
        mode = { "n", "t" },
        desc = "ToggleTerm #1 (float)",
      },

      -- Tools under the terminal umbrella
      -- {
      --   "<leader>tg",
      --   function()
      --     _LAZYGIT_TOGGLE()
      --   end,
      --   desc = "Lazygit (float)",
      -- },
      -- {
      --   "<leader>tb",
      --   function()
      --     _BTOP_TOGGLE()
      --   end,
      --   desc = "btop (float)",
      -- },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 12
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.35)
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,
      shading_factor = 1,
      start_in_insert = true,
      insert_mappings = false,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = false,
      close_on_exit = true,
      shell = vim.o.shell,

      -- Global float look for ToggleTerm
      float_opts = {
        border = "rounded",
        title = " 󰆍  Terminal ",
        title_pos = "center",
        width = function()
          return math.floor(vim.o.columns * 0.92)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.86)
        end,
        winblend = 0,
      },

      -- Theme-aware highlight links
      highlights = {
        Normal = { link = "NormalFloat" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Terminal QoL
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "Term: normal mode" })
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Term: normal mode" })
      vim.keymap.set("t", "kj", [[<C-\><C-n>]], { desc = "Term: normal mode" })
      vim.keymap.set("t", "<C-q>", [[<C-\><C-n>:close<cr>]], { silent = true, desc = "Term: close window" })

      local function set_terminal_keymaps()
        local o = { buffer = 0, silent = true }
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], o)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], o)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], o)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], o)
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          set_terminal_keymaps()

          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.cursorline = false
          vim.opt_local.list = false
          vim.opt_local.scrollback = 1000
          vim.opt_local.wrap = false
          vim.opt_local.spell = false
          vim.opt_local.statuscolumn = ""
          vim.opt_local.winbar = nil
          vim.wo.winhighlight = ""

          -- Close terminal window with `q` in NORMAL mode
          vim.keymap.set("n", "q", "<cmd>close<cr>", {
            buffer = 0,
            silent = true,
            desc = "Term: close window",
          })
        end,
      })

      -- Terminals: lazygit / btop / persistent #1
      local Terminal = require("toggleterm.terminal").Terminal

      -- local lazygit = Terminal:new({
      --   cmd = "lazygit",
      --   hidden = true,
      --   dir = "git_dir",
      --   direction = "vertical",
      --   size = 100,
      --   start_in_insert = true,
      --   shade_terminals = false,
      --   on_open = function(term)
      --     -- q to quit
      --     vim.keymap.set("t", "q", [[<C-\><C-n>:close<cr>]], { buffer = term.bufnr, silent = true })
      --   end,
      -- })
      -- function _LAZYGIT_TOGGLE()
      --   lazygit:toggle()
      -- end
      --
      -- local btop = Terminal:new({
      --   cmd = "btop",
      --   hidden = true,
      --   direction = "vertical",
      --   size = 100,
      --   start_in_insert = true,
      --   shade_terminals = false,
      -- })
      -- function _BTOP_TOGGLE()
      --   btop:toggle()
      -- end

      -- Named persistent float (id=1) handle if you want to call directly
      local float1 = Terminal:new({ hidden = true, direction = "float", id = 1 })
      function _FLOAT_TERM_TOGGLE()
        float1:toggle()
      end
    end,
  },

  -- Which-key: register a <leader>t group so it’s neat and discoverable
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      local wk = require("which-key")
      -- Add or merge groups (safe to call repeatedly)
      wk.add({
        { "<leader>t", group = "terminal" },
        { "<leader>tt", desc = "Terminal (float)" },
        { "<leader>tv", desc = "Terminal (vertical)" },
        { "<leader>th", desc = "Terminal (horizontal)" },
        { "<leader>tg", desc = "Lazygit (float)" },
        { "<leader>tb", desc = "btop (float)" },
      })
      return opts
    end,
  },
}

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      start_in_insert = true,
      persist_mode = true, -- keep insert/normal mode between opens
      persist_size = true, -- remember size
      close_on_exit = false, -- don't kill the shell when window closes
      direction = "float",
      float_opts = { border = "rounded" },
    },
    keys = {
      -- Toggle a single persistent floating shell from anywhere
      {
        "<leader>ft",
        function()
          -- open in the directory of the current file (fallback to cwd)
          local dir = vim.fn.expand("%:p:h")
          if dir == "" then
            dir = vim.loop.cwd()
          end
          require("toggleterm").toggle(1, nil, dir, "float")
        end,
        mode = { "n", "t" },
        desc = "Toggle Float Terminal",
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      -- Ensure terminal #1 exists and is float/persistent
      local Terminal = require("toggleterm.terminal").Terminal
      _G._float_term = _G._float_term
        or Terminal:new({
          id = 1,
          direction = "float",
          close_on_exit = false,
          hidden = true,
        })
      -- Optional: easy ESC behavior inside the terminal
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = function(ev)
          vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = ev.buf, silent = true })
        end,
      })
    end,
  },
}

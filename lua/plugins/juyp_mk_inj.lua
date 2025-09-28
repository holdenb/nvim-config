return {
  {
    -- No external repo; we just set queries via Lua on *.ju.py buffers
    "nvim-treesitter/nvim-treesitter",
    opts = {}, -- keep your existing TS config
    init = function()
      local aug = vim.api.nvim_create_augroup("JU_DOCSTRING_MD", { clear = true })

      -- Apply ONLY in *.ju.py buffers
      vim.api.nvim_create_autocmd("BufEnter", {
        group = aug,
        pattern = "*.ju.py",
        callback = function()
          -- Inject markdown into multi-line triple-quoted strings that are
          -- standalone expression statements (your Jupytext markdown cells).
          local query = [[
            ; Treat multi-line docstring-style strings as Markdown
            ((expression_statement
               (string
                 (string_content) @injection.content))
              (#lua-match? @injection.content "\n"))
            (#set! injection.language "markdown")
          ]]

          pcall(vim.treesitter.query.set, "python", "injections", query)

          -- Make it look nice in-buffer (conceal math/code fences, etc.)
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nc"
        end,
      })

      -- When leaving a *.ju.py buffer, restore default Python injections
      vim.api.nvim_create_autocmd("BufLeave", {
        group = aug,
        pattern = "*.ju.py",
        callback = function()
          -- nil resets to the default queries shipped by nvim-treesitter
          pcall(vim.treesitter.query.set, "python", "injections", nil)
        end,
      })
    end,
  },
}

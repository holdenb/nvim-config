return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    local lint = require("lint")

    opts.linters_by_ft = {
      python = { "ruff" },
      cpp = { "cpplint" },
    }

    -- Define cpplint linter
    lint.linters.cpplint = {
      name = "cpplint",
      cmd = "cpplint",
      stdin = false,
      args = {
        "--quiet",
        "--linelength=120",
        "--verbose=3",
      },
      stream = "stderr",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        local ignore_patterns = {
          "whitespace/line_length",
          "whitespace/indent",
          "legal/copyright",
        }

        for line in output:gmatch("[^\r\n]+") do
          local filename, lnum, severity, message = line:match("(%S+):(%d+):%s*(%w+):%s*(.*)")

          if filename and lnum and severity and message then
            -- Check if the message should be ignored
            local should_ignore = false
            for _, pattern in ipairs(ignore_patterns) do
              if message:find(pattern, 1, true) then
                should_ignore = true
                break
              end
            end

            -- Only insert diagnostics if they are NOT ignored
            if not should_ignore then
              table.insert(diagnostics, {
                bufnr = bufnr,
                lnum = tonumber(lnum) - 1, -- Convert to 0-based index
                col = 0,
                severity = ({
                  info = vim.diagnostic.severity.HINT,
                  warning = vim.diagnostic.severity.WARN,
                  error = vim.diagnostic.severity.ERROR,
                })[severity:lower()] or vim.diagnostic.severity.WARN, -- Default to WARN
                source = "cpplint",
                message = message,
              })
            end
          end
        end
        return diagnostics
      end,
    }

    -- Auto-trigger linting on save and buffer events
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

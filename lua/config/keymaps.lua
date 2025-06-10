-- Global keymaps --

-- Insert mode escape
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

-- Add empty lines before and after cursor line
vim.keymap.set("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
vim.keymap.set("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Allow Tab to skip past specific closing indicators
vim.keymap.set("i", "<Tab>", function()
  local col = vim.fn.col(".")
  local next_char = vim.fn.getline("."):sub(col, col)
  if vim.tbl_contains({ ")", "]", "}", "'", '"', "`" }, next_char) then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", true)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
  end
end, { expr = true })

------------------------------------------------------------------
-- Neovim keymaps --

-- Debugging keybinds
if not vim.g.vscode then
  local dap = require("dap")
  vim.keymap.set("n", "<Leader>ds", function()
    dap.continue()
  end, { desc = "Start Debugging" })
  vim.keymap.set("n", "<Leader>du", function()
    dap.step_over()
  end, { desc = "Step Over" })
  vim.keymap.set("n", "<Leader>di", function()
    dap.step_into()
  end, { desc = "Step Into" })
  vim.keymap.set("n", "<Leader>do", function()
    dap.step_out()
  end, { desc = "Step Out" })
  vim.keymap.set("n", "<Leader>b", function()
    dap.toggle_breakpoint()
  end, { desc = "Toggle Breakpoint" })
  vim.keymap.set("n", "<Leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "Conditional Breakpoint" })
  vim.keymap.set("n", "<Leader>dr", function()
    dap.repl.open()
  end, { desc = "Open Debug Console" })
  vim.keymap.set("n", "<Leader>dc", function()
    dap.repl.close()
  end, { desc = "Close Debug Console" })
  vim.keymap.set("n", "<Leader>dx", function()
    dap.terminate()
  end, { desc = "Stop Debugging" })
else
end

-- local dapui = require("dapui")
-- vim.keymap.set("n", "<leader>dq", function()
--   dapui.toggle()
-- end, { desc = "Toggle Debug UI" })
-- vim.keymap.set("n", "<leader>dq", function()
--   dapui.toggle()
-- end, { desc = "Toggle Debug UI" })

------------------------------------------------------------------
-- VSCode keymaps --

if vim.g.vscode then
  vim.keymap.set("n", "<leader>ca", function()
    vim.fn.VSCodeNotify("editor.action.quickFix")
  end, { desc = "Quick Fix (VSCode)" })
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bufls = {
          cmd = { "buf", "beta", "lsp", "--timeout=0", "--log-format=text" },
          filetypes = { "proto" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("buf.yaml", ".git")(fname)
          end,
        },
      },
    },
  },
}

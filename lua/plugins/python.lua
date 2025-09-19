return {
  -- Ensure servers are installed
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "basedpyright", "ruff", "taplo" })
    end,
  },

  -- LSP setup
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local util = require("lspconfig.util")

      local function ws_root(fname)
        return util.root_pattern("uv.lock", ".git", "pyproject.toml")(fname) or vim.loop.cwd()
      end

      vim.g.lazyvim_python_lsp = "basedpyright"
      vim.g.lazyvim_python_ruff = "ruff"

      opts.servers = opts.servers or {}

      -- Ruff LSP (lint/format/imports)
      opts.servers.ruff = {
        init_options = {
          settings = {
            organizeImports = true,
            lint = {
              enable = true,
            },
          },
        },
      }

      -- Use BasedPyright for hover, defs, completion, etc.
      opts.servers.basedpyright = {
        root_dir = ws_root,
        on_new_config = function(config, root_dir)
          local site = vim.fn.globpath(root_dir, ".venv/lib/*/site-packages", false, true)[1]
          config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
            -- basedpyright takes settings under `basedpyright.*`
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
                autoImportCompletions = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                extraPaths = site and { site } or {},
              },
            },
            -- These two python.* are still honored by BasedPyright for env picking
            python = {
              venvPath = root_dir,
              venv = ".venv",
            },
          })
        end,
      }

      -- (Optional) If ruff is stealing hover, can disable it with this
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if client and client.name == "ruff" then
      --       client.server_capabilities.hoverProvider = false
      --     end
      --   end,
      -- })
    end,
  },
}

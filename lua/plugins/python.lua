return {
  -- Requirements
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "basedpyright", "taplo" })
    end,
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local util = require("lspconfig.util")

      -- Configure the Python LSP to always use the workspace root .venv
      local function ws_root(fname)
        -- Prefer uv workspaces; fall back to git/pyproject
        return util.root_pattern("uv.lock", ".git", "pyproject.toml")(fname) or vim.loop.cwd()
      end

      opts.servers = opts.servers or {}

      opts.servers.ruff = {
        settings = {
          lint = true,
          organizeImports = true,
        },
      }

      opts.servers.pyright = {
        root_dir = ws_root,
        on_new_config = function(config, root_dir)
          -- Force LSP to resolve packages from the single venv at repo root
          local site = vim.fn.globpath(root_dir, ".venv/lib/*/site-packages", false, true)[1]
          config.settings = config.settings or {}
          config.settings.python = config.settings.python or {}
          config.settings.python.venvPath = root_dir
          config.settings.python.venv = ".venv"
          config.settings.python.analysis = vim.tbl_deep_extend("force", config.settings.python.analysis or {}, {
            typeCheckingMode = "standard",
            autoImportCompletions = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            reportMissingTypeStubs = "none",
            -- Fallback in case the server doesn't pick site-packages from venv:
            extraPaths = site and { site } or {},
          })
        end,
      }
    end,
  },
}

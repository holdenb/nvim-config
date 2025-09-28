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
    opts = {
      jupyter_command = "jupyter",
      default_notebook_URL = "localhost:8888/nbclassic",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}

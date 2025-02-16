return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    opts = vim.tbl_deep_extend("force", opts or {}, {
      fzf_opts = {
        ["--layout"] = "reverse",
      },
      files = {
        -- This is needed because 'jump_to_single_result' is now deprecated and
        -- gives a ton of warnings...
        jump1 = true, -- Replace 'jump_to_single_result' with 'jump1'
      },
      grep = {
        jump1 = true,
      },
    })
    return opts
  end,
}

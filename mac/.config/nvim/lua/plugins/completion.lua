return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          auto_show = false,
        },
        ghost_text = {
          enabled = function()
            return vim.g.ai_cmp and vim.bo.filetype ~= "markdown"
          end,
        },
      },
    },
  },
}

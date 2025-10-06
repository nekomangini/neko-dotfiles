-- lua with lazy.nvim
return {
  "max397574/better-escape.nvim",
  enabled = false,
  config = function()
    require("better_escape").setup {
      event = "VeryLazy",
      opts = {
        timeout = 300,
        default_mappings = false,
        mappings = {
          i = { j = { k = "<Esc>", j = "<Esc>" } },
        },
      },
    }
  end,
}

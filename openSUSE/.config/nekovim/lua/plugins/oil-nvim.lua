return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
        delete_to_trash = false,
        view_options = {
          show_hidden = true,
          natural_order = true,
        },
        win_options = {
          wrap = true,
        },
        keymaps = {
          ["g?"]    = "actions.show_help",
          ["<CR>"]  = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical   = true }, desc = "Open the entry in a vertical split" },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
          ["<C-t>"] = { "actions.select", opts = { tab        = true }, desc = "Open the entry in new tab" },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"]     = "actions.parent",
          -- ["gf"] = { function() require("oil").open_float() end, desc = "Open oil.nvim in a floating window" },
          ["_"]     = "actions.open_cwd",
          ["`"]     = "actions.cd",
          ["~"]     = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
          ["gs"]    = "actions.change_sort",
          ["gx"]    = "actions.open_external",
          ["g."]    = "actions.toggle_hidden",
          ["g\\"]   = "actions.toggle_trash",
        },
      })
    end
  }
}

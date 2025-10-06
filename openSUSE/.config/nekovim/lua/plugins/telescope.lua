return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    }
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        winblend = 10,                   -- Adjust transparency level as needed (0-100)
        -- layout_strategy = "bottom_pane", -- Makes pickers appear from bottom
        -- Or use this configuration for bottom positioning
        layout_config = {
          prompt_position = "top",
          height = 0.7, -- Adjust as needed
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<q>"] = actions.close, -- Add q to quit in insert mode
          },
          n = {
            ["q"] = actions.close, -- Add q to quit in normal mode
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load the FZF extension
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'flutter')
  end,
}

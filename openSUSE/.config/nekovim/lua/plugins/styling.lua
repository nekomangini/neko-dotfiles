return {
  -- nvim-colorizer
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup()
    end
  },
  -- vim-illuminate
  {
    "RRethy/vim-illuminate",
  },
  -- indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    enabled = false,
    opts = {},
    config = function()
      require("ibl").setup({
        indent = {
          char = "│", -- Use a thin vertical line for indents
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
        },
        exclude = {
          filetypes = {
            "help",
            "terminal",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
          },
        },
      })
    end,
  },
  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs                        = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged                 = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      })
    end,
    event = "BufReadPost",
  },
  -- lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled        = true,
          theme                = "gruvbox", --everforest, powerline, palenight, gruvbox, cyberdream
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
          disabled_filetypes   = {
            statusline = {},
            winbar = {},
            "alpha",
          },
          ignore_focus         = {},
          always_divide_middle = true,
          globalstatus         = false,
          refresh              = {
            statusline = 1000,
            tabline    = 1000,
            winbar     = 1000,
          },
        },
        sections = {
          -- lualine_a = { "mode" },
          lualine_a = { "branch" },
          lualine_b = {
            {
              "filename",
              file_status     = true,   -- Displays file status (modified, read-only)
              path            = 2,      -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Filename and parent dir
              shorting_target = 40,     -- Shortens path if it's longer than 40 characters
              symbols         = {
                modified = " ●",        -- Text to show when the file is modified
                readonly = " ",         -- Text to show when the file is non-modifiable or readonly
                unnamed  = "[No Name]", -- Text to show for unnamed buffers
              },
            },
          },
          -- lualine_c = { 'filetype', 'diff', 'diagnostics' },
          lualine_c = {
            "diff",
            "diagnostics",
          },
          -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
          -- lualine_x = { 'buffers' },
          -- show @recording messages(bottom right side)
          lualine_x = {
            -- Noice recording status
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              -- color = { fg = "#ff9e64" },
            },
          },
          lualine_y = {
            "filetype",
            -- Formatter status
            {
              function()
                local formatters = require("conform").list_formatters(0)
                if #formatters > 0 then
                  return formatters[1].name
                end
                return "No formatter"
              end,
              icon = " ",
              cond = function()
                return package.loaded["conform"] ~= nil
              end,
            },
          },
          lualine_z = { "progress", "location" },
          -- lualine_z = { '%=', '%t%m', '%3p' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
  -- smear.nvim
  {
    "sphamba/smear-cursor.nvim",
    enabled = not vim.g.neovide,            -- disable smear-cursor when using neovide
    opts = {                                -- Default  Range
      cursor_color                   = "#209fb5",
      stiffness                      = 0.8, -- 0.6      [0, 1]
      trailing_stiffness             = 0.5, -- 0.4      [0, 1]
      stiffness_insert_mode          = 0.7, -- 0.4      [0, 1]
      trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      damping                        = 0.5, -- 0.65     [0, 1]
      damping_insert_mode            = 0.8, -- 0.7      [0, 1]
      distance_stop_animating        = 0.5, -- 0.1      > 0

      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = false,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = false,
    },
  }
}

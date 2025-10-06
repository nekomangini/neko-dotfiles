return {
  -- autoclose.nvim
  {
    "m4xshen/autoclose.nvim",
    config = function()
      require("autoclose").setup()
    end,
  },
  -- nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "xml"
    },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        }
      })
    end,
  },
  -- resession.nvim
  {
    'stevearc/resession.nvim',
    opts = {},
    config = function()
    end
  },
  -- yanky.nvim
  {
    "gbprod/yanky.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      system_clipboard = {
        sync_with_ring = true, -- This enables automatic sync with system clipboard
      },
      highlight = {
        on_put  = true,
        on_yank = true,
        timer   = 160,
      },
    },
  },
  -- comment.nvim
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    events = "BufReadPost",
    opts = {},
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        mappings = {
          basic = false,
          extra = false,
        },
      })
    end,
  },
  -- neoscroll.nvim
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup({
        mappings = { -- Keys to be mapped to their corresponding default scrolling animation
          '<C-u>', '<C-d>',
          '<C-b>', '<C-f>',
          '<C-y>', '<C-e>',
          'zt', 'zz', 'zb',
        },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing = 'linear',           -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = false,    -- Disable "Performance Mode" on all buffers.
        ignored_events = {           -- Events ignored while scrolling
          'WinScrolled', 'CursorMoved'
        },
      })
    end
  }
}

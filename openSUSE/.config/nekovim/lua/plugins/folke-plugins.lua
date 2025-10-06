---@diagnostic disable: undefined-doc-name
return {
  -- todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    }
  },
  -- trouble tools
  {
    "folke/trouble.nvim",
    -- for default options, refer to the configuration section for custom setup.
    opts = {
      modes = {
        symbols = {
          desc  = "document symbols",
          mode  = "lsp_document_symbols",
          focus = true,
          win   = { position = "right" },
        },
      },
    },
    cmd = "Trouble",
  },
  -- flash.nvim
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true
        },
        char = {
          jump_labels = true,
        }
      }
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  -- twilight.nvim
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.34,                    -- amount of dimming
          color = { "Normal", "#ffffff" }, -- dimming color based on highlight groups or fallback
          term_bg = "#000000",             -- background color if guibg=NONE
          inactive = false,                -- fully dim other windows if true
        },
        context = 10,                      -- number of surrounding lines to show
        treesitter = true,                 -- use Treesitter for supported filetypes
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude certain filetypes from twilight
      })
    end,
    -- Optionally load it only when needed
    event = "BufReadPost",
  },
  -- noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      local noice = require("noice")
      -- fix: Gruvbox notification warning message
      local notify = require("notify")
      notify.setup({
        background_colour = "#000000",
      })
      noice.setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          -- you can enable a preset by setting it to true, or a table that will override the preset config
          -- you can also add custom presets that you can enable/disable with enabled=true
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        },
        views = {
          -- minimalist setup
          -- cmdline_popup = {
          --   border = {
          --     style = "none",
          --     padding = { 2, 3 },
          --   },
          --   filter_options = {},
          --   win_options = {
          --     winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          --   },
          -- },
        },
        routes = {
          -- Hides search messages count
          {
            filter = {
              event = "msg_show",
              kind = "search_count",
            },
            opts = { skip = true },
          },
          -- Filter out the "ready" notification
          {
            filter = {
              event = "msg_show",
              find = "ready",
            },
            opts = { skip = true },
          },
        },
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true, -- enables the Noice messages UI
          -- available options for view = notify, split, vsplit, popup, mini, cmdline, cmdline_popup, cmdline_output, messages, confirm, hover
          -- view = "notify",          -- default view for messages
          view = "mini",               -- change this to see the resession popup
          view_error = "notify",       -- view for errors
          view_warn = "notify",        -- view for warnings
          view_history = "messages",   -- view for :messages
          view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
      })
    end,
  },
  -- whichkey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      -- resession plugin
      local resession = require("resession")
      resession.setup()

      wk.setup({
        layout = {
          width = { min = 20 }, -- min and max width of the columns
          spacing = 5,          -- spacing between columns
        },
        show_help = true,       -- show a help message in the command line for using WhichKey
        show_keys = true,       -- show the currently pressed key and its label as a message in the command line
        plugins = {
          marks = true,         -- shows a list of your marks on ' and `
          registers = true,     -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          presets = {
            operators = true,    -- adds help for operators like d, y, ...
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
          },
        },

        -- sort = { "local", "order", "group", "alphanum", "mod" },
        sort = { "group" },

        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = " ", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
          ellipsis = "…",
          -- set to false to disable all mapping icons,
          -- both those explicitely added in a mapping and those from rules
          mappings = false,
          -- TODO:
          rules = {
            { pattern = "find", icon = " ", color = "green" },
            { pattern = "home", icon = "󰋜 ", color = "blue" },
            { pattern = "toggle", icon = "󰔡 ", color = "green" },
            { pattern = "quit", icon = "󰈆 ", color = "green" },
            { pattern = "save", icon = "󰆓 ", color = "green" },
            { pattern = "buffer", icon = " ", color = "green" },
            { pattern = "tools", icon = " ", color = "green" },
            { pattern = "plugin", icon = " ", color = "green" },
            { pattern = "terminal", icon = "  ", color = "green" },
            { pattern = "uppercase", icon = " ", color = "green" },
            { pattern = "lowercase", icon = " ", color = "green" },
            { pattern = "first", icon = "󰘀 ", color = "green" },
            { pattern = "last", icon = "󰘁 ", color = "green" },
          },
          -- use the highlights from mini.icons
          -- When `false`, it will use `WhichKeyIcon` instead
          colors = true,
          -- used by key format
          keys = {
            Up = " ",
            Down = " ",
            Left = " ",
            Right = " ",
            C = "󰘴 ",
            M = "󰘵 ",
            D = "󰘳 ",
            S = "󰘶 ",
            CR = "󰌑 ",
            Esc = "󱊷 ",
            ScrollWheelDown = "󱕐 ",
            ScrollWheelUp = "󱕑 ",
            NL = "󰌑 ",
            BS = "󰁮",
            Space = "󱁐 ",
            Tab = "󰌒 ",
            F1 = "󱊫",
            F2 = "󱊬",
            F3 = "󱊭",
            F4 = "󱊮",
            F5 = "󱊯",
            F6 = "󱊰",
            F7 = "󱊱",
            F8 = "󱊲",
            F9 = "󱊳",
            F10 = "󱊴",
            F11 = "󱊵",
            F12 = "󱊶",
          },
        },
      })
      wk.add({

        { "<leader>e",  "<cmd>Oil --float<cr>",       desc = "Open oil.nvim in a floating window" },

        -- buffer
        { "<leader>b",  group = "Buffer" },
        { "<leader>bD", "<cmd>bdelete!<cr>",          desc = "Force Delete Buffer" },
        { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
        { "<leader>bk", "<cmd>bdelete<cr>",           desc = "Delete Buffer" },
        { "<leader>ba", "<C-^>",                      desc = "Toggle between current file and alternate file" },

        -- Close all buffers except the current one
        {
          "<leader>bc",
          function()
            local current = vim.fn.bufnr("%")
            vim.cmd("silent! %bd|e#|bd#") -- Deletes all buffers except the current one
            vim.cmd("buffer " .. current) -- Reload the current buffer
            vim.cmd('echo "Closed all buffers except current"')
          end,
          desc = "Close all buffers except current",
        },

        -- Close the selected buffer
        {
          "<leader>bd",
          function()
            require("telescope.builtin").buffers({
              attach_mappings = function(prompt_bufnr, map)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                -- Map <CR> to close the selected buffer
                map("i", "<CR>", function()
                  local selection = action_state.get_selected_entry()
                  actions.close(prompt_bufnr)
                  vim.api.nvim_buf_delete(selection.bufnr, { force = false })
                end)

                -- Keep default mappings
                return true
              end,
            })
          end,
          desc = "Select and close buffer",
        },

        -- Close all buffers
        {
          "<leader>bC",
          function()
            local buffers = vim.api.nvim_list_bufs()
            for _, buf in ipairs(buffers) do
              if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
                local buf_name = vim.api.nvim_buf_get_name(buf)
                if vim.api.nvim_buf_get_option(buf, "modified") == false and buf_name ~= "" then
                  vim.api.nvim_buf_delete(buf, { force = true })
                end
              end
            end
          end,
          desc = "Close all buffers",
        },

        -- Horizontal split buffer
        {
          "<leader>b\\",
          function()
            require("telescope.builtin").buffers({
              attach_mappings = function(_, map)
                map("i", "<CR>", function(prompt_bufnr)
                  local action_state = require("telescope.actions.state")
                  local actions = require("telescope.actions")
                  local selected_entry = action_state.get_selected_entry()
                  actions.close(prompt_bufnr)
                  -- Open the selected buffer in a horizontal split
                  vim.cmd("split " .. selected_entry.value)
                end)
                return true
              end,
            })
          end,
          desc = "Select and open buffer in horizontal split",
        },

        -- Vertical split buffer
        {
          "<leader>b|",
          function()
            require("telescope.builtin").buffers({
              attach_mappings = function(_, map)
                map("i", "<CR>", function(prompt_bufnr)
                  local action_state = require("telescope.actions.state")
                  local actions = require("telescope.actions")
                  local selected_entry = action_state.get_selected_entry()
                  actions.close(prompt_bufnr)
                  -- Open the selected buffer in a vertical split
                  vim.cmd("vsplit " .. selected_entry.value)
                end)
                return true
              end,
            })
          end,
          desc = "Select and open buffer in vertical split",
        },

        -- swap buffers
        {
          "<leader>bs",
          function()
            local current_win = vim.api.nvim_get_current_win()
            local current_buf = vim.api.nvim_win_get_buf(current_win)
            local windows = vim.api.nvim_list_wins()

            for _, win in ipairs(windows) do
              if win ~= current_win then
                local other_buf = vim.api.nvim_win_get_buf(win)

                -- Skip empty/scratch buffers
                local buftype = vim.api.nvim_buf_get_option(other_buf, 'buftype')
                if buftype == "" then -- Normal file buffer
                  vim.api.nvim_win_set_buf(current_win, other_buf)
                  vim.api.nvim_win_set_buf(win, current_buf)
                  return
                end
              end
            end

            print("No other window with a file buffer found to swap with!")
          end,
          desc = "Swap buffers"
        },

        -- Telescope
        { "<leader>s",  group = "Search" },
        -- { "<leader>fH", "<cmd>Telescope commands<cr>",                  desc = "Find Commands" },
        -- { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Find Help" },
        -- { "<leader>fk", "<cmd>Telescope keymaps<cr>",                   desc = "Find Keymaps" },
        -- { "<leader>fr", "<cmd>Telescope registers<cr>",                 desc = "Find Registers" },
        -- { "<leader>f'", "<cmd>Telescope marks<cr>",                     desc = "Find Marks" },
        -- { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
        -- { "<leader>fs", "<cmd>w<cr>",     desc = "Save File" },
        -- { "<leader>h", "<cmd>Alpha<cr>", desc = "Home Screen" },
        -- { "<leader>fC", "<cmd>Telescope grep_string<cr>", desc = "Find Word References in Active Directory" },
        -- { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODO" },
        { "<leader>sh", function() Snacks.picker.help() end,               desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.commands() end,           desc = "Commands" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,            desc = "Keymaps" },
        { '<leader>sr', function() Snacks.picker.registers() end,          desc = "Registers" },
        { "<leader>sm", function() Snacks.picker.marks() end,              desc = "Marks" },
        { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics() end,        desc = "Diagnostics in Root Directory" },
        { "<leader>sC", function() Snacks.picker.grep_word() end,          desc = "Visual selection or word in Active Directory", mode = { "n", "x" } },
        { "<leader>sb", function() Snacks.picker.lines() end,              desc = "Buffer Lines" },
        { "<leader>su", function() Snacks.picker.undo() end,               desc = "Undo History" },
        { "<leader>ss", function() Snacks.picker.colorschemes() end,       desc = "Colorschemes" },
        {
          "<leader>sc",
          function()
            local word = vim.fn.expand("<cword>")
            require("telescope.builtin").current_buffer_fuzzy_find({
              default_text = word,
              prompt_title = "Search in Current Buffer",
            })
          end,
          desc = "Find Word References in Current Buffer",
        },
        { "<leader>sw", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                                  desc = "Find Words in Current Buffer" },
        { "<leader>sW", "<cmd>Telescope live_grep<cr>",                                                  desc = "Find Words In All Files" },

        { "<leader>f",  group = "Find/File" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                                   desc = "Find Recent Files" },
        { "<leader>fn", "<cmd>Telescope notify<cr>",                                                     desc = "Find Notifications" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>",                                                 desc = "Find Files" },
        -- { "<leader>fF", function() require("snacks").picker.files { hidden = true, ignored = true } end, desc = "Find Files" },
        { "<leader>fe", function() Snacks.explorer() end,                                                desc = "File Explorer" },
        { "<leader>fb", function() Snacks.picker.buffers() end,                                          desc = "Find Buffers" },
        { "<leader>ft", function() Snacks.picker.todo_comments() end,                                    desc = "Find Todo/Notes" },
        { "<leader>fT", function() Snacks.picker.todo_comments({ keywords = { "FIX", "FIXME" } }) end,   desc = "Find Fix/Fixme" },
        { "<leader>fs", "<cmd>w<cr>",                                                                    desc = "File Save" },
        { "<leader>fo", "<cmd>FlutterOutlineToggle<cr> ",                                                desc = "Flutter Outline Toggle" },
        --
        -- search
        -- { "<leader>fj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        -- { "<leader>fl", function() Snacks.picker.loclist() end, desc = "Location List" },
        -- { "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        -- { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },

        -- { "<leader>q", group = "quit"},
        { "<leader>Q",  "<cmd>wq<cr>",                                                                   desc = "Save and Quit" },
        { "<leader>q",  "<cmd>q<cr>",                                                                    desc = "Quit" },

        -- lazy and mason
        { "<leader>P",  group = "Plugins" },
        {
          "<leader>Pu",
          "<cmd>Lazy update<cr><cmd>MasonUpdate<cr>",
          desc = "Update Lazy and Mason",
        },
        { "<leader>Pi", "<cmd>Lazy install<cr>", desc = "Plugin Install" },
        { "<leader>Pm", "<cmd>Mason<cr>",        desc = "Mason Installer" },
        { "<leader>PM", "<cmd>MasonUpdate<cr>",  desc = "Mason Update" },
        { "<leader>Ps", "<cmd>Lazy<cr>",         desc = "Plugins Status" },
        { "<leader>PS", "<cmd>Lazy sync<cr>",    desc = "Plugins Sync" },
        {
          "<leader>Pc",
          "<cmd>Lazy check<cr>",
          desc = "Plugins Check Update",
        },
        { "<leader>PU", "<cmd>Lazy update<cr>",                      desc = "Plugins Update" },

        -- git
        { "<leader>g",  group = "Git" },
        { "<leader>gg", "<cmd>LazyGit<cr>",                          desc = "LazyGit" },
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end,      desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end,   desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end,    desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end,     desc = "Git Diff (Hunks)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },


        -- lsp
        { "<leader>l",  group = "Language tools" },
        {
          "<leader>ld",
          vim.lsp.buf.definition,
          desc = "Go to Definition",
        },
        { "<leader>lF", vim.lsp.buf.references,         desc = "Find References" },
        { "<leader>lr", vim.lsp.buf.rename,             desc = "Rename" },
        -- { "<leader>la", vim.lsp.buf.code_action,                             desc = "Code Action" },
        { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
        {
          "<leader>lf",
          function()
            vim.lsp.buf.format({ async = true })
          end,
          desc = "Format Code",
        },

        -- Home keybind for alpha.nvim
        { "<leader>h", "<cmd>Alpha<cr>", desc = "Home Screen" },

        { "<leader>n", "<cmd>enew<cr>",  desc = "New File" },

        -- comment toggle
        {
          "<leader>/",
          function()
            local mode = vim.api.nvim_get_mode().mode
            if mode == "n" then
              require("Comment.api").toggle.linewise.current()
            elseif mode:match("[vV\22]") then -- v, V, or Ctrl+V (block mode)
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
              require("Comment.api").toggle.linewise(vim.fn.visualmode())
            end
          end,
          mode = { "n", "v" },
          desc = "Toggle Comment",
        },
        -- { "<leader>c",  group = "Vue Toggle Comment" },
        -- { "<leader>cj", "I// <Esc>",                    mode = { "n", "v" },      desc = "Vue Script Toggle Comment" },
        -- {
        --   "<leader>cj",
        --   function()
        --     local mode = vim.api.nvim_get_mode().mode
        --
        --     -- Function to check if a line starts with comment and toggle it
        --     local function toggle_comment(line_text)
        --       -- Check if the line already starts with "// "
        --       if line_text:match("^%s*// ") then
        --         -- Remove comment by replacing the first occurrence of "// "
        --         return line_text:gsub("^(%s*)// ", "%1", 1)
        --       else
        --         -- Add comment to the beginning after any whitespace
        --         return line_text:gsub("^(%s*)", "%1// ", 1)
        --       end
        --     end
        --
        --     if mode == "n" then
        --       -- In normal mode, toggle comment on current line
        --       local line_num = vim.fn.line(".")
        --       local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
        --       local new_text = toggle_comment(line_text)
        --       vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_text })
        --     elseif mode:match("[vV\22]") then -- v, V, or Ctrl+V (block mode)
        --       -- Exit visual mode first to ensure marks are set
        --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
        --
        --       -- Get the start and end lines, ensuring start <= end
        --       local start_line = math.min(vim.fn.line("'<"), vim.fn.line("'>"))
        --       local end_line = math.max(vim.fn.line("'<"), vim.fn.line("'>"))
        --
        --       -- Get all lines in the selection
        --       local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
        --
        --       -- Toggle comments on each line
        --       local new_lines = {}
        --       for i = 1, #lines do
        --         new_lines[i] = toggle_comment(lines[i])
        --       end
        --
        --       -- Replace the lines with the new versions
        --       vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
        --     end
        --   end,
        --   mode = { "n", "v" },
        --   desc = "Vue Script Toggle Comment",
        -- },
        -- { "<leader>cc", "I/* <Esc>A */<Esc>",           mode = { "n", "v" },      desc = "Vue Style Toggle Comment" },
        -- {
        --   "<leader>cc",
        --   function()
        --     local mode = vim.api.nvim_get_mode().mode
        --
        --     -- Function to check if a line has CSS comment and toggle it
        --     local function toggle_comment(line_text)
        --       -- Check if the line is already commented with /* */
        --       if line_text:match("^%s*/%*") and line_text:match("%*/%s*$") then
        --         -- Remove comments by replacing /* at start and */ at end
        --         return line_text:gsub("^(%s*)/%*%s*(.-)%s*%*/%s*$", "%1%2")
        --       else
        --         -- Add comments at start and end
        --         return line_text:gsub("^(%s*)(.-)$", "%1/* %2 */")
        --       end
        --     end
        --
        --     if mode == "n" then
        --       -- In normal mode, toggle comment on current line
        --       local line_num = vim.fn.line(".")
        --       local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
        --       local new_text = toggle_comment(line_text)
        --       vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_text })
        --     elseif mode:match("[vV\22]") then -- v, V, or Ctrl+V (block mode)
        --       -- Exit visual mode first to ensure marks are set
        --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
        --
        --       -- Get the start and end lines, ensuring start <= end
        --       local start_line = math.min(vim.fn.line("'<"), vim.fn.line("'>"))
        --       local end_line = math.max(vim.fn.line("'<"), vim.fn.line("'>"))
        --
        --       -- Get all lines in the selection
        --       local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
        --
        --       -- Toggle comments on each line
        --       local new_lines = {}
        --       for i = 1, #lines do
        --         new_lines[i] = toggle_comment(lines[i])
        --       end
        --
        --       -- Replace the lines with the new versions
        --       vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
        --     end
        --   end,
        --   mode = { "n", "v" },
        --   desc = "Vue Style Toggle Comment",
        -- },

        -- { "<leader>t",   group = "Extra tools" },
        -- PERF, HACK, TODO, NOTE, FIX, WARNING. Add a : after the word
        -- {
        --   "<leader>tn",
        --   function()
        --     require("todo-comments").jump_next()
        --   end,
        --   desc = "Next todo comment",
        -- },
        -- {
        --   "<leader>tp",
        --   function()
        --     require("todo-comments").jump_prev()
        --   end,
        --   desc = "Next todo comment",
        -- },
        -- You can also specify a list of valid jump keywords
        -- vim.keymap.set("n", "]t", function()
        --   require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
        -- end, { desc = "Next error/warning todo comment" })
        -- resizing panes
        { "<leader>w",  group = "Windows", },
        { "<leader>wl", "<cmd>vertical resize +30<cr>",                                    desc = "Increase window width" },
        { "<leader>wL", "<cmd>vertical resize +70<cr>",                                    desc = "Greatly increase window width" },
        { "<leader>wh", "<cmd>vertical resize -30<cr>",                                    desc = "Decrease window width" },
        { "<leader>wH", "<cmd>vertical resize -30<cr>",                                    desc = "Greatly decrease window width" },
        { "<leader>wj", "<cmd>resize +10<cr>",                                             desc = "Increase window heigth" },
        { "<leader>wk", "<cmd>resize -10<cr>",                                             desc = "Decrease window heigth" },

        -- terminal
        { "<leader>x",  group = "Tools" },
        { "<leader>xf", function() require('telescope').extensions.flutter.commands() end, desc = "Flutter Commands" },
        { "<leader>xF", "<cmd>Lspsaga term_toggle<cr>",                                    desc = "ToggleTerm Float" },
        { "<leader>xR", function() Snacks.rename.rename_file() end,                        desc = "Rename File" },
        {
          "<leader>xh",
          function()
            vim.opt.number = false             -- Toggles line numbers
            vim.opt.relativenumber = false     -- Toggles relative number
            vim.cmd.vnew()                     -- Creates a new vertical window
            vim.cmd.term()                     -- Opens a terminal in the new window
            vim.cmd.wincmd("J")                -- Moves the terminal window to the bottom of the screen
            vim.api.nvim_win_set_height(0, 10) -- Sets the height of the current window to 10 lines
          end,
          desc = "ToggleTerm Horizontal",
        },
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>xs",
          "<cmd>Trouble symbols toggle<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>xl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },

        -- Toggle
        { "<leader>t",  group = "Toggle" },
        { "<leader>tt", "<Cmd>Twilight<cr>",                           desc = "Toggle twilight" },
        { "<leader>tz", function() Snacks.zen() end,                   desc = "Toggle Zen Mode" },
        { "<leader>tZ", function() Snacks.zen.zoom() end,              desc = "Toggle Zoom" },
        { "<leader>tn", function() Snacks.notifier.show_history() end, desc = "Notification History" },


        -- resession
        { "<leader>S",  group = "Session tools" },
        { "<leader>Ss", resession.save,                                desc = "Save Session" },
        { "<leader>Sl", resession.load,                                desc = "Load Session" },
        { "<leader>Sd", resession.delete,                              desc = "Delete Session" },

        -- yanky
        {
          -- Copy to system clipboard | Normal mode and Visual mode
          mode = { "n", "v" },
          { "<leader>y", "\"+y", desc = "Copy to system clipboard" },
        }

      })
    end,
  },
  -- snacks
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      ---@type table<string, snacks.win.Config>
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
        minimal = {
          wo = {
            winblend = 20,
          },
        }
      },
    },
  }
}

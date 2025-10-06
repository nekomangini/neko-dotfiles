return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'stevearc/dressing.nvim', -- optional for vim.ui.select
      -- When you run FlutterDevices a popup will show up and that is the dressing.nvim
    },
    -- config = true,
    config = function()
      -- local on_attach = function(client, bufnr)
      --   -- Define keybindings, etc. for LSP
      --   local opts = { buffer = bufnr }
      -- end
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("flutter-tools").setup({
        fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
        widget_guides = {
          enabled = true,
        },
        -- debugger = {
        --   enabled = true,
        --   run_via_dap = true,
        --   exception_breakpoints = {},
        --   -- register_configurations = function(_)
        --   --   require("dap").configurations.dart = {}
        --   --   require("dap.ext.vscode").load_launchjs()
        --   -- end,
        -- },
        lsp = {
          color = {                    -- show the derived colours for dart variables
            enabled = true,            -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = true,         -- highlight the background
            background_color = nil,    -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            foreground = false,        -- highlight the foreground
            virtual_text = true,       -- show the highlight using virtual text
            virtual_text_str = "■",    -- the virtual text character to highlight
          },
          -- on_attach = on_attach,       -- Use your LSP on_attach function
          capabilities = capabilities, -- Use your LSP capabilities
        },
        closing_tags = {
          highlight = "ErrorMsg",      -- highlight for the closing tag
          prefix = ">",                -- character to use for close tag e.g. > Widget
          priority = 10,               -- priority of virtual text in current line
          -- consider to configure this when there is a possibility of multiple virtual text items in one line
          -- see `priority` option in |:help nvim_buf_set_extmark| for more info
          enabled = true -- set to false to disable
        },
        -- dev_log = {
        --   enabled = true,
        --   filter = nil, -- optional callback to filter the log
        --   -- takes a log_line as string argument; returns a boolean or nil;
        --   -- the log_line is only added to the output if the function returns true
        --   notify_errors = false, -- if there is an error whilst running then notify the user
        --   open_cmd = "tabedit",  -- command to use to open the log buffer
        -- },
        -- dev_tools = {
        --   autostart = false,         -- autostart devtools server if not detected
        --   auto_open_browser = false, -- Automatically opens devtools in the browser
        -- },
        -- outline = {
        --   open_cmd = "30vnew", -- command to use to open the outline buffer
        --   auto_open = false    -- if true this will open the outline automatically when it is first populated
        -- },
        -- see the link below for details on each option:
        -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
        -- settings = {
        --   -- showTodos = true,
        --   completeFunctionCalls = true,
        --   analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
        --   renameFilesWithClasses = "prompt", -- "always"
        --   enableSnippets = true,
        --   updateImportsOnRename = true,      -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
        -- }
      })
    end
  }
}

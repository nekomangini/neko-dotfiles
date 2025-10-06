return {
  "b0o/blender.nvim",
  enabled = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "grapp-dev/nui-components.nvim",
    "mfussenegger/nvim-dap", -- Optional, for debugging with DAP
    "LiadOz/nvim-dap-repl-highlights", -- Optional, for syntax highlighting in the DAP REPL
  },
  config = function()
    require("blender").setup {
      profiles = { --                 Profile[]?            list of blender profiles
        --
        {
          name = 'blender', --        string                profile name, must be unique
          cmd = 'blender', --         string|string[]       command to run Blender
          -- env = {}, --             { [string]: string }  environment variables to set when starting Blender
          -- use_launcher = true --   boolean?              whether to run the launcher.py script when starting Blender
          -- extra_args = {} --       string[]?             extra arguments to pass to Blender
          -- enable_dap = nil --      boolean?              whether to enable DAP for this profile (if nil, the global setting is used)
          -- watch = nil --           boolean?              whether to watch the add-on directory for changes (if nil, the global setting is used)
        },
      },
      dap = { --                      DapConfig?            DAP configuration
        enabled = true, --            boolean?              whether to enable DAP (can be overridden per profile)
      },
      notify = { --                   NotifyConfig?         notification configuration
        enabled = true, --            boolean?              whether to enable notifications
        verbosity = 'INFO', --        'TRACE'|'DEBUG'|'INFO'|'WARN'|'ERROR'|'OFF'|vim.log.level?  log level for notifications
      },
      watch = { --                    WatchConfig?          file watcher configuration
        enabled = true, --            boolean?              whether to watch the add-on directory for changes (can be overridden per profile)
      },
      ui = { --                      UiConfig?             UI configuration
        output_panel = { --          { height: number }    output panel configuration
          height = 0.25, --          number                height of the output panel. if 0 < height < 1, the height is a percentage of the window height
        },
      },
    }  
  end,
}

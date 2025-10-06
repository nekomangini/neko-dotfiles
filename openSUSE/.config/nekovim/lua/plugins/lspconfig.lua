return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      'saghen/blink.cmp',
    },
    config = function()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require("lspconfig")
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- auto_install = true, -- automatically install a language
        ensure_installed = {
          "clangd",
          "bashls",
          "fish_lsp",
          "gopls",
          "lua_ls",
          "marksman",
          "raku_navigator",
          "rust_analyzer",
          "taplo",
          "yamlls",
          "pyright",
          "ruff",
          "html",
          "cssls",
          "astro",
          "ts_ls",
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          ["clangd"] = function()
            require("lspconfig").clangd.setup({
              capabilities = capabilities,
              cmd = { "clangd", "--background-index" },
              root_dir = require("lspconfig").util.root_pattern("compile_commands.json", ".git"),
            })
          end,

          ["fish_lsp"] = function()
            require("lspconfig").fish_lsp.setup({
              capabilities = capabilities,
            })
          end,

          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,

          ["raku_navigator"] = function()
            require("lspconfig").raku_navigator.setup({
              settings = {
                raku_navigator = {
                  rakuPath = "raku",
                },
              },
            })
          end,

          ["pyright"] = function()
            lspconfig.pyright.setup({
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic", -- "off", "basic", "strict"
                  },
                },
              },
            })
          end,

          ["ruff"] = function()
            lspconfig.ruff.setup({
              capabilities = capabilities,
              init_options = {
                settings = {
                  -- Ruff language server settings
                  args = {},
                }
              }
            })
          end,

          ["astro"] = function ()
            lspconfig.astro.setup({
              capabilities = capabilities
            })
          end,

          ["gopls"] = function ()
            lspconfig.gopls.setup({
              capabilities = capabilities,
              cmd = {"gopls"},
              filetypes = {"go", "gomod", "gowork", "gotmpl"},
              root_dir = util.root_pattern("go.work", "go.mod", ".git"),
              settings = {
                gopls = {
                  completeUnimported = true,
                  usePlaceholders = true,
                  analyses = {
                    unusedparams = true
                  }
                }
              }
            })
          end
        },
        formatters = {
          prettierd = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
        },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "bash-language-server",
          "clang-format",
          "lua-language-server",
          "marksman",
          "markdownlint-cli2",
          "markdown-toc",
          "prettierd",
          "selene",
          "shfmt",
          "stylua",
          "yaml-language-server",
          "yamlfix",
          -- Python tools
          "pyright",
          "ruff",
          "black",           -- Python formatter
          "isort",           -- Python import sorter
          "debugpy",         -- Python debugger
          "mypy",            -- Static type checker
          "htmlhint",
          "stylelint",
          "typescript-language-server",
        },
        formatters = {
          prettierd = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
        },
      })
    end,
  },

  {
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "javascriptreact", "typescriptreact", "astro" },
    init = function()
      vim.g.user_emmet_settings = {
        html = {
          default_attributes = {
            "id",
            "class",
          },
        },
      }
      -- IMPORTANT: Set a specific leader key for Emmet expansion
      -- This prevents conflicts with your completion plugin's <CR> or <C-y>
      -- vim.g.user_emmet_leader_key = '<C-E>,'
    end,
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c                = { "clang_format" },
          cpp              = { "clang_format" },
          fish             = { "fish_indent" },
          lua              = { "stylua" },

          -- You can customize some of the format options for the filetype (:help conform.format)
          rust             = { "rustfmt", lsp_format = "fallback" },

          go               = { "goimports", "gofmt", lsp_format = "last" },
          ["markdown"]     = { "prettierd", "markdownlint-cli2", "markdown-toc" },
          ["markdown.mdx"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
          sh               = { "shfmt" },
          python           = { "isort", "black" },
          html             = { "prettierd" },
          css              = { "prettierd" },
          scss             = { "prettierd" },
          less             = { "prettierd" },
          astro            = { "prettierd" },
          javascript       = { "prettierd" },
          typescript       = { "prettierd" },
        },
      })
    end,
  },
  -- linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        markdown         = { "markdownlint-cli2" },
        html             = { "htmlhint" },
        css              = { "stylelint" },
        scss             = { "stylelint" },
        less             = { "stylelint" },
      }

      -- Lint on save
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  -- lsp ui
  {
    "nvimdev/lspsaga.nvim",
    -- enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons",     -- optional
    },
    event = "LspAttach",                 -- Load when LSP attaches
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = true,        -- Keep feature enabled
          sign = false,         -- Disable sign column light bulb
          virtual_text = false, -- Disable virtual text light bulb
          enable_in_insert = false,
        },
      })
    end,
  },
  -- -- snippet
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- follow latest release.
  --   version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --   -- install jsregexp (optional!).
  --   build = "make install_jsregexp",
  --   dependencies = {
  --     "saadparwaiz1/cmp_luasnip",
  --     "rafamadriz/friendly-snippets",
  --   },
  -- },
  -- -- autocompletion
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --   },
  --   config = function()
  --     -- Explicitly load HTML and Vue snippets
  --     require("luasnip.loaders.from_vscode").lazy_load({ include = { "html", "vue" } })
  --     local cmp = require("cmp")
  --     local luasnip = require("luasnip")
  --
  --     cmp.setup({
  --       -- Sources for autocompletion
  --       sources = cmp.config.sources({
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --       }, {
  --         { name = 'buffer' },
  --         { name = 'path' },
  --       }),
  --       snippet = {
  --         expand = function(args)
  --           require('luasnip').lsp_expand(args.body)
  --         end,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ['<C-b>']     = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>']     = cmp.mapping.scroll_docs(4),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<C-e>']     = cmp.mapping.abort(),
  --         ['<CR>']      = cmp.mapping.confirm({ select = true }),
  --       }),
  --       -- Enable documentation popups
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(), -- Nice border for documentation
  --       },
  --     })
  --
  --     -- Command line completion setup
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "cmdline" },
  --         { name = "path" },
  --       },
  --       formatters = {
  --         prettierd = {
  --           prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
  --         },
  --         prettier = {
  --           prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
  --         },
  --       },
  --     })
  --
  --     -- Buffer completion setup
  --     cmp.setup.cmdline("/", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --       formatters = {
  --         prettierd = {
  --           prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
  --         },
  --         prettier = {
  --           prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      -- keymap = { preset = 'default' }, -- uses <C-y>
      keymap = { preset = 'super-tab' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
}

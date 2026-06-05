{ pkgs, ... }:

{
  programs.helix.languages.language-server = {
    # --- HTML ---
    vscode-html-language-server.command = "vscode-html-language-server";
    vscode-html-language-server.args = [ "--stdio" ];

    # --- CSS ---
    vscode-css-language-server.command = "vscode-css-language-server";
    vscode-css-language-server.args = [ "--stdio" ];

    # --- Typescript ---
    "typescript-language-server" = {
      command = "typescript-language-server";
      args = [ "--stdio" ];
      config = {
        plugins = [
          {
            name = "@vue/typescript-plugin";
            # location = "${pkgs.vue-language-server}/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin";
            # location = "${pkgs.vue-vue-language-server}/lib/node_modules/@vue/typescript-plugin";
            location = "${pkgs.vue-language-server}/lib/language-tools/packages/language-server/node_modules/@vue/typescript-plugin";
            languages = [ "vue" ];
          }
        ];
      };
    };

    # --- Emmet ---
    "emmet-ls" = {
      command = "emmet-ls";
      args = [ "--stdio" ];
    };

    # --- Astro ---
    "astro-ls" = {
      command = "astro-ls";
      args = [ "--stdio" ];
      config = {
        typescript = {
          # tsdk = "node_modules/typescript/lib";
          tsdk = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib";
        };
      };
    };

    # --- Svelte ---
    "svelteserver" = {
      command = "svelteserver";
      args = [ "--stdio" ];
    };

    # --- Nix ---
    "nixd".command = "nixd";

    # --- Bash ---
    "bash-language-server" = {
      command = "bash-language-server";
      args = [ "start" ];
    };

    # --- Ruby ---
    "ruby-lsp".command = "ruby-lsp";
    "solargraph".command = "solargraph";

    # --- Dart ---
    "dart-analysis-server" = {
      command = "dart";
      args = [ "language-server" ];
    };

    # --- GO ---
    gopls = {
      command = "gopls";
      config = {
        gofumpt = true;
        staticcheck = true;
        analyses = {
          unusedparams = true;
          shadow = true;
        };
        usePlaceholders = true;
        completeUnimported = true;
        matcher = "fuzzy";
      };
    };

    # --- Python ---
    "pyright" = {
      command = "pyright-langserver";
      args = [ "--stdio" ];
      config = {
        pythoni = {
          analysis = {
            typeCheckingMode = "basic";
            autSearchPaths = true;
            useLibraryCodeForTypes = true;
          };
        };
      };
    };

    # --- C/C++ ---
    "clangd" = {
      command = "clangd";
      args = [
        "--background-index"
        "--clang-tidy"
        "--completion-style=detailed"
        "--header-insertion=never"
      ];
    };

    # --- Java Language Server ---
    "jdtls" = {
      command = "jdtls";
      args = [
        "-data"
        ".jdtls-workspace"
      ];
    };
  };
}

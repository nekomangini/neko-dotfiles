{ pkgs, ... }:

{
  programs.helix.languages.language-server = {
    vscode-html-language-server.command = "vscode-html-language-server";
    vscode-html-language-server.args = [ "--stdio" ];

    vscode-css-language-server.command = "vscode-css-language-server";
    vscode-css-language-server.args = [ "--stdio" ];

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

    "emmet-ls" = {
      command = "emmet-ls";
      args = [ "--stdio" ];
    };

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

    "svelteserver" = {
      command = "svelteserver";
      args = [ "--stdio" ];
    };

    "nixd".command = "nixd";

    "bash-language-server" = {
      command = "bash-language-server";
      args = [ "start" ];
    };

    "ruby-lsp".command = "ruby-lsp";
    "solargraph".command = "solargraph";

    "dart-analysis-server" = {
      command = "dart";
      args = [ "language-server" ];
    };

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
  };
}

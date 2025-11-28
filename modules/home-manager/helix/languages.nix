{ ... }:

{
  programs.helix.languages = {
    language = [
      # --- web stuff ---
      {
        name = "html";
        language-servers = [
          "vscode-html-language-server"
          "emmet-ls"
        ];
        auto-format = true;
      }
      {
        name = "css";
        language-servers = [
          "vscode-css-language-server"
          "emmet-ls"
        ];
        auto-format = true;
      }
      {
        name = "javascript";
        language-servers = [
          "typescript-language-server"
          "emmet-ls"
        ];
        auto-format = true;
      }
      {
        name = "typescript";
        language-servers = [
          "typescript-language-server"
          "emmet-ls"
        ];
        auto-format = true;
      }
      {
        name = "jsx";
        language-servers = [
          "typescript-language-server"
          "emmet-ls"
        ];
        auto-format = true;
      }
      {
        name = "tsx";
        language-servers = [
          "typescript-language-server"
          "emmet-ls"
        ];
        auto-format = true;
      }
      # --- Astro ---
      {
        name = "astro";
        scope = "source.astro";
        injection-regex = "astro";
        file-types = [ "astro" ];
        roots = [
          "package.json"
          "astro.config.mjs"
        ];
        language-servers = [
          "astro-ls"
          "emmet-ls"
        ];
        auto-format = true;
      }
      # --- Svelte ---
      {
        name = "svelte";
        language-servers = [
          "svelteserver"
          "emmet-ls"
        ];
      }

      # --- Nix ---
      {
        name = "nix";
        language-servers = [
          "nixd"
          "nil"
        ];
        formatter = {
          command = "nixfmt";
        };
        auto-format = true;
      }

      # --- Bash ---
      {
        name = "bash";
        language-servers = [ "bash-language-server" ];
        formatter = {
          command = "shfmt";
        };
        auto-format = true;
      }

      # --- Ruby ---
      {
        name = "ruby";
        language-servers = [
          "ruby-lsp"
          "solargraph"
        ];
        # rubocop
        # formatter = {
        #   command = "rubocop";
        #   args = [
        #     "--stdin"
        #     "file.rb"
        #     "-a"
        #     "--stderr"
        #     "--fail-level"
        #     "fatal"
        #   ];
        # };

        # rufo
        formatter = {
          command = "rufo";
          args = [ "--simple-exit" ];
        };
        auto-format = true;
      }

      # --- ERB (Embedded Ruby) for Rails views ---
      {
        name = "erb";
        language-servers = [
          {
            name = "ruby-lsp";
            only-features = [
              "format"
              "diagnostics"
            ];
          }
          {
            name = "solargraph";
            except-features = [
              "format"
              "diagnostics"
            ];
          }
          "emmet-ls"
        ];
        # Only .erb files, not all .html
        file-types = [ "erb" ];
        formatter = {
          command = "htmlbeautifier";
          args = [
            "--tab-stops"
            "2"
            # Preserve up to 2 consecutive blank lines
            "--keep-blank-lines"
            "2"
          ];
        };
        auto-format = true;
      }
    ];
  };
}

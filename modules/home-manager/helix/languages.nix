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

      # --- Dart/Flutter ---
      {
        name = "dart";
        scope = "source.dart";
        injection-regex = "dart";
        file-types = [ "dart" ];
        roots = [ "pubspec.yaml" ];
        language-servers = [ "dart-analysis-server" ];
        auto-format = true;
      }

      # --- Go ---
      {
        name = "go";
        scope = "source.go";
        injection-regex = "go";
        file-types = [ "go" ];
        roots = [
          "go.mod"
          "go.work"
        ];
        language-servers = [ "gopls" ];
        formatter = {
          command = "goimports";
        };
        auto-format = true;
      }

      # --- Go Templates (for Hugo) ---
      {
        name = "gohtml";
        scope = "text.html.go";
        injection-regex = "gohtml";
        file-types = [ "gohtml" ];
        language-servers = [ "gopls" ];
        auto-format = false;
      }

      # --- Go Template (.tmpl files) ---
      {
        name = "gotmpl";
        scope = "source.gotmpl";
        file-types = [
          "tmpl"
          "tpl"
        ];
        language-servers = [ "gopls" ];
        auto-format = false;
      }

      # --- TOML (for Hugo config) ---
      {
        name = "toml";
        auto-format = true;
      }

      # --- YAML (for Hugo front matter) ---
      {
        name = "yaml";
        auto-format = true;
      }

      # --- Markdown (Hugo) ---
      {
        name = "markdown";
        language-servers = [ "marksman" ];
        formatter = {
          command = "prettier";
          args = [
            "--parser"
            "markdown"
          ];
        };
        auto-format = true;
      }

    ];
  };
}

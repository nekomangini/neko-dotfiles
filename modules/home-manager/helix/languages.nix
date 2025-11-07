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

      # --- Nix ---
      {
        name = "nix";
        language-servers = [
          "nixd"
          "nil"
        ];
        formatter = {
          # command = "nixfmt-rfc-style";
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

      # --- Ruby / Rails ✅ ---
      {
        name = "ruby";
        language-servers = [
          "ruby-lsp"
          "solargraph"
        ];
        formatter = {
          command = "rufo";
        };
        auto-format = true;
      }
    ];
  };
}

{ pkgs, ... }:

{
  # -----------------------------------------------
  # Helix Editor Configuration (Moved from home.nix)
  # -----------------------------------------------

  programs.helix = {
    enable = true;
    package = pkgs.helix;

    settings = {
      theme = "everforest_dark";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        end-of-line-diagnostics = "hint";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp.display-inlay-hints = true;
      };

      keys = {
        insert.j.k = "normal_mode";

        normal = {
          # C-g: Launch Lazygit
          "C-g" = [
            ":new"
            ":insert-output lazygit"
            ":buffer-close!"
            ":redraw"
          ];

          # C-y: Launch Yazi (File Picker)
          "C-y" = [
            ":sh rm -f /tmp/unique-file"
            ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
            ''
              :insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty
            ''
            ":open %sh{cat /tmp/unique-file}"
            ":redraw"
          ];

          "space" = {
            F = "no_op";
            q = ":quit";
          };

          space.f = {
            F = "file_picker_in_current_directory";
            b = "file_picker_in_current_buffer_directory";
            f = "file_picker";
            o = ":open ~/.config/helix/config.toml";
            s = ":write";
          };
        };
      };
    };

    languages = {
      language = [
        { name = "html"; language-servers = [ "vscode-html-language-server" "emmet-ls" ]; auto-format = true; indent = { tab-width = 2; unit = "  "; }; }
        { name = "css"; language-servers = [ "vscode-css-language-server" "emmet-ls" ]; auto-format = true; indent = { tab-width = 2; unit = "  "; }; }
        { name = "javascript"; language-servers = [ "typescript-language-server" "emmet-ls" ]; auto-format = true; indent = { tab-width = 2; unit = "  "; }; }
        { name = "typescript"; language-servers = [ "typescript-language-server" "emmet-ls" ]; auto-format = true; indent = { tab-width = 2; unit = "  "; }; }
        { name = "jsx"; language-servers = [ "typescript-language-server" "emmet-ls" ]; auto-format = true; indent = { tab-width = 2; unit = "  "; }; }
        { name = "tsx"; language-servers = [ "typescript-language-server" "emmet-ls" ]; auto-format = true; indent = { tab-width = 2; unit = "  "; }; }

        { name = "nix"; language-servers = [ "nix" "nixd" ]; formatter = "nixfmt-rfc-style"; auto-format = true; }
      ];

      language-server = {
        vscode-html-language-server = { command = "vscode-html-language-server"; args = [ "--stdio" ]; };
        vscode-css-language-server = { command = "vscode-css-language-server"; args = [ "--stdio" ]; };
        "typescript-language-server" = { command = "typescript-language-server"; args = [ "--stdio" ]; };
        "emmet-ls" = { command = "emmet-ls"; args = [ "--stdio" ]; };

        "nix" = { command = "nil"; };
        "nixd" = { command = "nixd"; };
      };
    };
  };
}


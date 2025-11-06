{ ... }:

{
  programs.helix.languages.language-server = {
    vscode-html-language-server.command = "vscode-html-language-server";
    vscode-html-language-server.args = [ "--stdio" ];

    vscode-css-language-server.command = "vscode-css-language-server";
    vscode-css-language-server.args = [ "--stdio" ];

    "typescript-language-server" = {
      command = "typescript-language-server";
      args = [ "--stdio" ];
    };

    "emmet-ls" = {
      command = "emmet-ls";
      args = [ "--stdio" ];
    };

    "nixd".command = "nixd";

    "bash-language-server" = {
      command = "bash-language-server";
      args = [ "start" ];
    };

    "ruby-lsp".command = "ruby-lsp";
    "solargraph".command = "solargraph";
  };
}

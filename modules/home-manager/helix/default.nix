{ pkgs, ... }:

{
  imports = [
    ./editor.nix
    ./languages.nix
    ./servers.nix
  ];

  programs.helix.enable = true;

  programs.helix.extraPackages = with pkgs; [
    bash-language-server
    shfmt

    nil
    nixd
    nixfmt-rfc-style

    clojure-lsp

    typescript-language-server
    vscode-langservers-extracted
    emmet-ls

    ruby-lsp
    solargraph
    rufo
    rubocop
  ];
}

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

    astro-language-server
    svelte-language-server
    typescript-language-server
    vscode-langservers-extracted
    emmet-ls

    gopls
    gotools
    gomodifytags
    impl
    delve

    marksman
    prettier

    ruby-lsp
    solargraph
    rufo
    rubocop
    rubyPackages.htmlbeautifier
  ];
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    shellcheck
    pandoc
    marksman

    bash-language-server
    shfmt

    clojure-lsp
    sbcl

    gopls
    (lib.lowPrio gotools)
    gomodifytags
    impl
    delve
    gotests
    gore

    nil
    nixd
    nixfmt-rfc-style

    html-tidy
    stylelint
    emmet-ls
    js-beautify
    prettier
    astro-language-server
    svelte-language-server
    vscode-langservers-extracted
    vue-language-server
    typescript-language-server

    ruby-lsp
    solargraph
    rufo
    rubocop
    # rubyPackages.htmlbeautifier

    pyright
    black
  ];
}

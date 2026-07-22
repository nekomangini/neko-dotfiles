{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Markdown
    shellcheck
    pandoc
    marksman

    # bash
    bash-language-server
    shfmt

    # C/C++
    # clang
    # (lib.hiPrio gcc)
    cmake
    gcc
    gnumake
    clang-tools

    # Clojure
    clojure
    leiningen
    clj-kondo
    clojure-lsp

    # Common Lisp
    sbcl

    # Java jdk24
    jdk21_headless
    jdt-language-server

    # Go
    go
    gopls
    (lib.lowPrio gotools)
    gomodifytags
    impl
    delve
    gotests
    gore

    # Nix
    nil
    nixd
    nixfmt

    # Web
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
    typescript
    bun
    nodejs_22

    # Ruby
    ruby-lsp
    solargraph
    rufo
    rubocop
    # rubyPackages.htmlbeautifier

    # Python
    python315
    pyright
    black

    # Game Development
    godot

    # Static Site Generators
    hugo
    zola

    # lua
    lua

    # raku
    rakudo

    # Rust
    rustup
    lldb
  ];
}

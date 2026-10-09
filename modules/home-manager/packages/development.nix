{ pkgs, ... }:

{
  home.packages = with pkgs; [
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

    # emacs orgmode
    mermaid-cli

    # fish
    fish-lsp

    # Game Development
    godot

    # Go
    go
    gopls
    (lib.lowPrio gotools)
    gomodifytags
    impl
    delve
    gotests
    gore

    # Java jdk24
    jdk21_headless
    jdt-language-server

    # lua
    lua
    lua-language-server
    luau
    luau-lsp
    stylua
    luarocks

    # Markdown
    shellcheck
    pandoc
    marksman

    # Nix
    nil
    nixd
    nixfmt

    # Python
    python315
    pyright
    black

    # raku
    rakudo

    # Ruby
    ruby-lsp
    solargraph
    rufo
    rubocop
    # rubyPackages.htmlbeautifier

    # Rust
    rustup
    lldb

    # Static Site Generators
    hugo
    zola

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
  ];
}

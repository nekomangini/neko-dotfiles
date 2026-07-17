{ pkgs, ... }:

let
  helix = pkgs.helix;
  kitty = pkgs.kitty;
  tmux = pkgs.tmux;

  # emacs = pkgs.emacs-gtk;
  emacs = pkgs.emacs-gtk.pkgs.withPackages (epkgs: [
    epkgs.treesit-grammars.with-all-grammars
  ]);
in

# TODO
# Simplify/Move to scripts/default.nix if possible
{
  home.packages = with pkgs; [
    # ===== Emacs =====
    (writeShellScriptBin "nkt" ''
      exec ${emacs}/bin/emacsclient -nw -a "" "$@"
    '')

    (writeShellScriptBin "doom-terminal" ''
      exec ${kitty}/bin/kitty --hold ${emacs}/bin/emacsclient -nw -a ""
    '')

    # ===== Wayland =====
    # TEST
    # (writeShellScriptBin "hed" ''
    #   exec ${emacs-pgtk}/bin/emacsclient -nw
    # '')

    # ===== Scripts=====
    # Joplin
    (writeShellScriptBin "helix-joplin" ''
      COMMAND_ARRAY=("${helix}/bin/hx" "$@")
      exec ${kitty}/bin/kitty ${tmux}/bin/tmux new-session -A -s joplin "''${COMMAND_ARRAY[@]}"
    '')

    # ===== AUTOMATION =====
  ];
}

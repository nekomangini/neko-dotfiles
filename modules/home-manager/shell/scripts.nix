{ pkgs, ... }:

let
  helix = pkgs.helix;
  emacs = pkgs.emacs;
  kitty = pkgs.kitty;
  tmux = pkgs.tmux;
in

{
  home.packages = with pkgs; [
    # ===== Emacs =====
    (writeShellScriptBin "ed" ''
      exec ${emacs}/bin/emacsclient -nw
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

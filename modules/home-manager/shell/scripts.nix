{ pkgs, ... }:

let
  helix = pkgs.helix;
  kitty = pkgs.kitty;
  tmux = pkgs.tmux;
  foot = pkgs.foot;

  # emacs = pkgs.emacs-gtk;
  emacs = pkgs.emacs-pgtk.pkgs.withPackages (epkgs: [
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

    # NOTE: Used in wayland session
    (writeShellScriptBin "doom-foot-terminal" ''
      if ! ${foot}/bin/footclient -- ${emacs}/bin/emacsclient -nw -a "" 2>/dev/null; then
        ${foot}/bin/foot --server &
        sleep 0.3
        exec ${foot}/bin/footclient -- ${emacs}/bin/emacsclient -nw -a ""
      fi
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

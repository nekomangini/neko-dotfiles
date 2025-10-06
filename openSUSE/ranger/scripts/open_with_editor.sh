#!/bin/bash
# Script to choose an editor for programming files
file="$1"
echo "Select an editor for $file:"
PS3="Choose an editor: "
options=("nk" "nvim" "nvide" "lvide" "kak" "hx" "lvim")

handle_editor() {
  case "$1" in
  "nk")
    NVIM_APPNAME="nekovim" nvim "$2"
    ;;
  "nvide")
    nohup ~/Downloads/neovide.AppImage "$2" >/dev/null 2>&1 &
    disown
    ;;
  "lvide")
    nohup ~/.config/lvim/lvim-nvide.sh "$2" >/dev/null 2>&1 &
    disown
    ;;
  *)
    "$1" "$2"
    ;;
  esac
}

select editor in "${options[@]}"; do
  if [ -n "$editor" ]; then
    handle_editor "$editor" "$file"
    break
  fi
done

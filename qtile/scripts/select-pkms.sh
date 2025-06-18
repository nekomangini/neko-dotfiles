#!/bin/bash

# Pkms options
options=(
  "logseq"
  "joplin"
  "obsidian"
  "appflowy"
)

# rofi selection
selected=$(
  printf "%s\n" "${options[@]}" | rofi -dmenu \
    -i \
    -p "Select" \
    -theme-str 'window {width: 400px; height: 320px;}' \
    -theme-str 'listview {lines: 5; scrollbar: false;}' \
    -theme-str 'mainbox {children: [ "inputbar", "listview" ];}'
)

# execute base on selection
case "$selected" in
"logseq")
  gtk-launch logseq &
  ;;
"joplin")
  gtk-launch joplin &
  ;;
"obsidian")
  gtk-launch obsidian &
  ;;
"appflowy")
  gtk-launch appflowy &
  ;;
*)
  echo "Invalid selection: $selected"
  exit 1
  ;;
esac

exit 0

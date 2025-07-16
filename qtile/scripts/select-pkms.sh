#!/bin/bash

# Pkms options
options=(
  "logseq"
  "joplin"
  "obsidian"
  "appflowy"
  "ticktick"
  "todoist"
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
"ticktick")
  /home/nekomangini/Ticktick/ticktick.AppImage &
  ;;
"todoist")
  /home/nekomangini/Todoist/Todoist-linux-9.17.0-x86_64-latest.AppImage &
  ;;
*)
  echo "Invalid selection: $selected"
  exit 1
  ;;
esac

exit 0

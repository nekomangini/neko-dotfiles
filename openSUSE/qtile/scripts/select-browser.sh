#!/bin/bash

# Browser options
options=(
  "brave"
  "vivaldi"
  "zen"
  "qutebrowser"
  "Cancel"
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
"brave")
  brave-browser
  ;;
"vivaldi")
  vivaldi-stable
  ;;
"zen")
  /home/nekomangini/zen/zen
  ;;
"qutebrowser")
  qutebrowser
  ;;
"Cancel")
  exit 0
  ;;
*)
  echo "Invalid selection: $selected"
  exit 1
  ;;
esac

exit 0

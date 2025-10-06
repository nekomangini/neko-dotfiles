#!/bin/bash

# Editor options
options=(
  "Zed"
  "Visual Studio Code"
  "Android Studio"
  "IntelliJ Idea"
  "IntelliJ Pycharm"
  "IntelliJ Clion"
  "IntelliJ RustRover"
  "IntelliJ Rider"
)

# rofi selection
selected=$(
  printf "%s\n" "${options[@]}" | rofi -dmenu \
    -i \
    -p "Select Editor" \
    -theme-str 'window {width: 400px; height: 320px;}' \
    -theme-str 'listview {lines: 6; scrollbar: false;}' \
    -theme-str 'mainbox {children: [ "inputbar", "listview" ];}'
)

# launch editor base on selection
case "$selected" in
"Zed")
  zed &
  ;;
"Visual Studio Code")
  code &
  ;;
"Android Studio")
  gtk-launch "Android Studio-1b260a3d-8790-40cd-a925-277f07c6f21e" &
  ;;
"IntelliJ Idea")
  gtk-launch "IntelliJ IDEA Community Edition-5e6d944b-cce8-4fc7-8612-dc8b1118b904" &
  ;;
"IntelliJ Pycharm")
  gtk-launch "PyCharm Community-db429a1b-d0a4-41f1-b4f8-49fda5f0d5a9" &
  ;;
"IntelliJ Clion")
  gtk-launch Clion &
  ;;
"IntelliJ RustRover")
  gtk-launch "jetbrains-rustrover" &
  ;;
"IntelliJ Rider")
  gtk-launch "jetbrains-rider" &
  ;;
*)
  echo "Invalid selection: $selected"
  ;;
esac

exit 0

#!/bin/bash

# Menu options
options=(
    "Shutdown"
    "Reboot"
    "Suspend"
    "Hibernate"
    "Lock"
    "Cancel"
)

# Prompt user with rofi and get selection, with custom styling
selected=$(printf "%s\n" "${options[@]}" | rofi -dmenu \
    -i \
    -p "Select" \
    -theme-str 'window {width: 200px; height: 260px;}' \
    -theme-str 'listview {lines: 6;}' \
    -theme-str 'mainbox {children: [ "inputbar", "listview" ];}')

# Execute command based on selection
case "$selected" in
"Shutdown")
    systemctl poweroff
    ;;
"Reboot")
    systemctl reboot
    ;;
"Suspend")
    systemctl suspend
    ;;
"Hibernate")
    systemctl hibernate
    ;;
"Lock")
    i3lock -i /home/nekomangini/Pictures/wallpaper/Mechs/wallhaven-kxlz67.png
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

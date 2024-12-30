#!/bin/bash

# Define menu options
options=(
    "Shutdown"
    "Reboot"
    "Suspend"
    "Hibernate"
    "Lock"
    "Cancel"
)

# Prompt user with dmenu and get selection
selected=$(printf "%s\n" "${options[@]}" | dmenu -i -p "Action:")
# selected=$(printf "%s\n" "${options[@]}" | dmenu -i -p "Action:" -fn 'monospace:size=12' -nb '#111111' -nf '#bbbbbb' -sb '#285577' -sf '#ffffff' -h 20)




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
        # loginctl terminate-user nekomangini
        # gnome-session-quit --logout
        systemctl restart gdm
        ;;
    "Hibernate")
        systemctl hibernate
        # sudo systemctl hibernate
        ;;
    "Lock")
        i3lock
        #.config/qtile/scripts/blur-lock
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


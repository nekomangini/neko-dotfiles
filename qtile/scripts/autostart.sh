#!/usr/bin/bash

picom &
dunst &
nitrogen --restore &

if ! pgrep -  "emacs --daemon" >/dev/null; then
    emacs --daemon &
    sleep 1.6
    notify-send "Emacs daemon running" -u normal
fi

sleep 2
wezterm start --always-new-process &

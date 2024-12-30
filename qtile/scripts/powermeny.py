#!/usr/bin/env python3

import os
import subprocess

# Configuration
FG_COLOR = "#bbbbbb"
BG_COLOR = "#111111"
HLFG_COLOR = "#111111"
HLBG_COLOR = "#bbbbbb"
BORDER_COLOR = "#222222"

ROFI_OPTIONS = ["-theme", "~/.config/rofi/powermenu.rasi"]
ZENITY_TITLE = "Power Menu"
ZENITY_TEXT = "Action:"
ZENITY_OPTIONS = ["--column=", "--hide-header"]

enable_confirmation = False
preferred_launcher = "rofi"

# Menu options
menu = {
    " Shutdown": "systemctl poweroff",
    " Reboot": "systemctl reboot",
    " Suspend": "systemctl suspend",
    " Hibernate": "systemctl hibernate",
    " Lock": "~/.config/i3/scripts/blur-lock",
    " Logout": "qtile cmd-obj -o cmd -f shutdown",
    " Cancel": ""
}

menu_confirm = {"Shutdown", "Reboot", "Hibernate", "Suspend", "Logout"}

def command_exists(command):
    return subprocess.call(["which", command], stdout=subprocess.PIPE, stderr=subprocess.PIPE) == 0

def ask_confirmation(selection):
    confirmed = False
    if preferred_launcher == "rofi":
        confirmed = subprocess.run(
            ["rofi", "-dmenu", "-i", "-lines", "2", "-p", f"{selection}?",
             "-bc", BORDER_COLOR, "-bg", BG_COLOR, "-fg", FG_COLOR,
             "-hlfg", HLFG_COLOR, "-hlbg", HLBG_COLOR, *ROFI_OPTIONS],
            input="Yes\nNo", text=True, capture_output=True
        ).stdout.strip() == "Yes"
    elif preferred_launcher == "zenity":
        confirmed = subprocess.call(["zenity", "--question", "--text", f"Are you sure you want to {selection.lower()}?"]) == 0

    return confirmed

def main():
    launcher_exe = None
    launcher_options = []
    selection = ""

    if preferred_launcher == "rofi" and command_exists("rofi"):
        launcher_exe = "rofi"
        launcher_options = ["-dmenu", "-i", "-lines", str(len(menu)), "-p", "Select action",
                            "-bc", BORDER_COLOR, "-bg", BG_COLOR, "-fg", FG_COLOR,
                            "-hlfg", HLFG_COLOR, "-hlbg", HLBG_COLOR, *ROFI_OPTIONS]
    elif preferred_launcher == "zenity" and command_exists("zenity"):
        launcher_exe = "zenity"
        launcher_options = ["--list", "--title", ZENITY_TITLE, "--text", ZENITY_TEXT, *ZENITY_OPTIONS]

    if launcher_exe:
        if launcher_exe == "rofi":
            selection = subprocess.run(
                [launcher_exe, *launcher_options],
                input="\n".join(menu.keys()), text=True, capture_output=True
            ).stdout.strip()
        elif launcher_exe == "zenity":
            selection = subprocess.run(
                [launcher_exe, *launcher_options],
                input="\n".join(menu.keys()), text=True, capture_output=True
            ).stdout.strip()

    if selection and selection in menu:
        if enable_confirmation and selection in menu_confirm:
            if ask_confirmation(selection):
                os.system(menu[selection])
        else:
            os.system(menu[selection])

if __name__ == "__main__":
    main()



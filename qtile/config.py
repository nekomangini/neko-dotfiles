# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os, json # psutil
import subprocess
import json
from themes.pywal_colors import load_colors # colors,

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy

# from libqtile.utils import guess_terminal

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration, BorderDecoration, RectDecoration
# import custom config
from custom_colors import *
from utils.volume_notification import show_volume_notification

from themes.theme_manager import ThemeManager
theme_manager = ThemeManager()
current_theme = theme_manager.get_current_theme()

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    subprocess.Popen([home])

@hook.subscribe.setgroup
def reload_pywal_colors():
    with open(os.path.expanduser('~/.config/qtile/current_theme.json'), 'r') as f:
        if json.load(f)['theme'] == 'pywal':
            load_colors('/home/nekomangini/.cache/wal/colors')
            lazy.reload_config()

@hook.subscribe.startup_once
def start_once():
    import subprocess
    subprocess.call([os.path.expanduser("wal"), "-R"])

mod = "mod4"

terminal = "wezterm"
terminal_tmux = "wezterm start -- tmux new-session -A -s main"
doom = "sh -c 'emacsclient -c -a \"emacs\"'"

# fonts
mono_fur_font_bold   = "MonofurNerdFont Bold"
mono_fur_font        = "MonofurNerdFont"
jetbrains_font_propo = "JetBrainsMono Nerd Font Propo Light"
jetbrains_font_nl    = "JetBrainsMonoNL Nerd Font"
jetbrains_font_bold  = "JetBrainsMono Nerd Bold"
terminess_font       = "Terminess Nerd Font Mono"
notosans_tagalog     = "Noto Sans Tagalog"
caskaydia_font       = "CaskaydiaMono Nerd Font,CaskaydiaMono NF:style=Bold"
small_ft             = 14

# qtile extras
border_decor = {
    "decorations": [BorderDecoration(
        colour = current_theme['widget_theme']['this_current_screen_border'],  # using your theme color
        border_width = [0, 0, 3, 0],  # Underlined style
        padding_x = 5,
        padding_y = None,
        group = False,
    )]
}

powerline_forward_slash = {
    "decorations": [PowerLineDecoration(
            colour=current_theme['widget_theme']['this_current_screen_border'],
            path="forward_slash",
            size=10,
        )
    ]
}
powerline_back_slash = {
    "decorations": [PowerLineDecoration(
            colour=current_theme['widget_theme']['this_current_screen_border'],
            path="back_slash",
            size=10,
        )
    ]
}

underline_decor = {
    "decorations": [
        RectDecoration(
            colour=current_theme['widget_theme']['this_current_screen_border'],
            radius=0,
            group=True,
            filled=False,
        )
    ]
}

# Define widget defaults using current theme
widget_defaults = dict(
    font=jetbrains_font_nl,
    fontsize=small_ft,
    foreground=current_theme['widget_theme']['foreground'],
    background=current_theme['widget_theme']['background'],
)
extension_defaults = widget_defaults.copy()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html

    # Hide qtile bar
    Key([mod], "x", lazy.hide_show_bar(), desc="Toggle qtile bar"),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows for monadtall, monadwide, columns and treetab
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left().when(layout=["monadtall", "monadwide", "columns"]),
        lazy.layout.move_left().when(layout=["treetab"]),
        desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right().when(layout=["monadtall", "monadwide", "columns"]),
        lazy.layout.move_right().when(layout=["treetab"]),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down().when(layout=["monadtall", "monadwide", "columns"]),
        lazy.layout.move_down().when(layout="treetab"),
        desc="Move window down"
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up().when(layout=["monadtall", "monadwide", "columns"]),
        lazy.layout.move_up().when(layout="treetab"),
        desc="Move window up"
    ),
    # Grow windows for columns,monadtall,monadwide. Move section for treetab
    # https://github.com/qtile/qtile/discussions/3736
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left().when(layout="columns"),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left/Shrink window"),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right().when(layout="columns"),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the right/Grow window"
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down().when(layout="columns"),
        lazy.layout.section_down().when(layout="treetab"),
        desc="Grow window down"
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up().when(layout="columns"),
        lazy.layout.section_up().when(layout="treetab"),
        desc="Grow window up"
    ),
    # treetab
    Key(
        [mod, "shift"],
        "a",
        lazy.layout.add_section("New Section"),
        desc="Add a new section to TreeTab layout"
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key(
    #     [mod, "shift"],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.prev_layout(), desc="Toggle between layouts"),

    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Key([mod], "Tab", lazy.screen.next_group(), desc="Toggle between groups"),
    # Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
    Key([mod], "o", lazy.screen.next_group(), desc="Go to next group"),
    Key([mod], "i", lazy.screen.prev_group(), desc="Go to previous group"),
    Key([mod], "backslash",  lazy.screen.toggle_group(), desc="Move to the last visited group"),
    Key([mod], "tab", lazy.screen.toggle_group(), desc="Move to the last visited group"),

    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # if there is a prompt widget, activate this line of code
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # Minimize layout
    # Key(["mod"], "Tab", lazy.window.toggle_minimize()),  # Switch to previous window
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "m",
        lazy.window.toggle_maximize().when(layout=["monadtall", "monadwide", "columns"]),
        desc="Grow the currently focused client to the max size",
    ),
    Key(
        [mod],
        "n",
        lazy.layout.normalize().when(layout="columns"),
        lazy.layout.reset().when(layout=["monadtall", "monadwide"]),
        desc="Reset all window sizes",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    # launch rofi
    Key(
        [mod],
        "d",
        lazy.spawn(
            # "rofi -modi drun -show drun \ -config ~/.config/rofi/rofidmenu.rasi"
            # "rofi -modi drun -show drun"
            "rofi -modi drun -show drun -theme-str 'listview {scrollbar: false;}'"
        ),
    ),
    # launch terminal
    # Key([mod], "Return", lazy.group["vim"].toscreen(),  lazy.spawn(terminal), desc="Launch terminal"),
    Key(
        [mod],
        "Return",
        lazy.group["1"].toscreen(toggle=False),
        lazy.spawn(terminal),
        desc="Launch terminal",
    ),
    Key(
        [mod, "control"],
        "Return",
        lazy.group["1"].toscreen(toggle=False),
        lazy.spawn(terminal_tmux),
        desc="Launch terminal",
    ),
    # emacs
    Key(
        [mod],
        "e",
        lazy.group["3"].toscreen(toggle=False),
        lazy.spawn(doom),
        desc="Launch Emacs client",
    ),
    Key(
        [mod],
        "b",
        lazy.spawn(".config/qtile/scripts/select-browser.sh"),
        desc="Launch browser selector",
    ),
    # pkms applications
    Key(
        [mod],
        "a",
        lazy.spawn(".config/qtile/scripts/select-pkms.sh"),
        desc="Launch pkms applications selector",
    ),
    Key(
        [mod, "shift"],
        "g",
        lazy.group["1"].toscreen(toggle=False),
        lazy.spawn("wezterm cli spawn -- lazygit"),
        desc="Launch File Manager",
    ),
    Key(
        [mod, "shift"],
        "n",
        lazy.group["1"].toscreen(toggle=False),
        lazy.group["scratchpad"].dropdown_toggle("ranger"),
        # lazy.spawn("wezterm cli spawn  -- ranger"),
        desc="Launch File Manager",
    ),
    ### ScratchPad ###
    Key(
        [mod],
        "s",
        lazy.spawn(".config/qtile/scripts/keybind.sh"),
        desc="Show Qtile keybindings"
    ),
    Key(
        [mod],
        "g",
        lazy.group["scratchpad"].dropdown_toggle("lazygit"),
        desc="Toggle Lazygit dropdown"
    ),
    Key(
        [mod, "shift"],
        "Return",
        lazy.group["scratchpad"].dropdown_toggle("lunarvim"),
        desc="Toggle Lazygit dropdown"
    ),
    # screenshot
    # using absolute path
    Key(
        [],
        "Print",
        lazy.spawn(".config/qtile/scripts/screenshot.sh"),
        desc="Printscreen",
    ),
    # exit-menu
    Key(
        [mod], "p", lazy.spawn(".config/qtile/scripts/powermenu.sh"), desc="Launch PowerMenu",
    ),
    # switch windows
    Key(
        # [mod], "w", lazy.spawn("rofi -theme sidebar -show window"), desc="Select Window",
        [mod], "w", lazy.spawn("rofi -show window run -theme-str 'listview {scrollbar: false;}'"), desc="Select Window",
        # [mod], "w", lazy.spawn("rofi -show window"), desc="Select Window",
    ),
    # Wallpaper changer
    # Key(
    #     [mod, "shift"], "w",
    #     lazy.spawn("bash -c 'PREVIEW=true rofi -theme fullscreen-preview -show filebrowser -filebrowser-command \"feh --bg-scale\" -filebrowser-directory ~/Pictures/wallpapers'"),
    #     desc="Change wallpaper with rofi"
    # ),
    Key(
        [mod, "shift"], "w",
        lazy.group["scratchpad"].dropdown_toggle("wallpaperchanger"),
        desc="Change wallpaper with yazi"
    ),
    # lock
    # Key([mod, "shift"], "p", lazy.spawn("i3lock"), desc="LockScreen"),
    # Volume control
    # using script
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("amixer set Master 1%+"),
        # lazy.function(show_volume_notification),
        desc="Increase volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("amixer set Master 1%-"),
        # lazy.function(show_volume_notification),
        desc="Decrease volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("amixer set Master toggle"),
        # lazy.function(show_volume_notification),
        desc="Mute volume",
    ),
]

# Used https://kuyabai.com/?q=ang+gwapo+ko+po+talaga
group_names = [
    ("1", {"layout": "treetab", "label": "ᜀ", "matches": [
        Match(wm_class="Wezterm"),
        Match(wm_class="dev.zed.Zed"),
        Match(wm_class="code"),
        Match(wm_class="jetbrains-studio"),
        Match(wm_class="jetbrains-idea-ce"),
        Match(wm_class="jetbrains-pycharm-ce"),
        Match(wm_class="jetbrains-clion"),
    ]}),
    ("2", {"layout": "monadtall", "label": "ᜅ᜔", "matches": [
        Match(wm_class="zen"),
        Match(wm_class="qutebrowser"),
        Match(wm_class="vivaldi-stable"),
        Match(wm_class="brave"),
    ]}),
    ("3", {"layout": "max", "label": "ᜄ᜔", "matches": [
        Match(wm_class="Emacs"),
        Match(wm_class="obsidian"),
    ]}),
    ("4", {"layout": "max", "label": "ᜏ", "matches": [
        Match(wm_class="AppFlowy"),
    ]}),
    ("5", {"layout": "monadtall", "label": "ᜉᜓ", "matches": [
        Match(wm_class="gwenview"),
        Match(wm_class="dolphin")
    ]}),
    ("6", {"layout": "max", "label": "ᜉᜓ", "matches": [
        Match(wm_class="gimp-3.0"),
        Match(wm_class="krita"),
        Match(wm_class="libresprite")
    ]}),
    ("7", {"layout": "monadtall", "label": "ᜃᜓ", "matches": [
        Match(wm_class="logseq"),
        Match(wm_class="Joplin")
    ]}),
    ("8", {"layout": "max", "label": "ᜆ", "matches": [Match(wm_class="Blender")]}),
    ("9", {"layout": "max", "label": "ᜎ", "matches": [Match(wm_class="Houdini FX")]}),
    ("0", {"layout": "treetab", "label": "ᜄ", "matches": [
        Match(wm_class="Godot"),
        Match(wm_class="com.defold.editor.Start")
    ]}),
]

# Create groups with labels
groups = [Group(name, **kwargs) for name, kwargs in group_names]


# Create groups from the group_names list
# groups = [Group(name, **kwargs) for name, kwargs in group_names]

# Add ScratchPad for dropdowns
groups.append(
    ScratchPad("scratchpad", [
        DropDown(
            "ranger",
            terminal + " -e ranger",  # Using your terminal variable
            opacity=0.9,
            height=0.7,
            width=0.7,
            x=0.15,
            y=0.15,
            on_focus_lost_hide=True  # Changed to True for traditional behavior
        ),
        DropDown(
            "lazygit",
            terminal + " -e lazygit",
            opacity=0.9,
            height=0.7,
            width=0.7,
            x=0.15,
            y=0.15,
            on_focus_lost_hide=True
        ),
        DropDown(
            "lunarvim",
            terminal + " -e bash -c 'cd /run/media/nekomangini/D/scratchpad-files/ && lvim'",
            opacity=0.9,
            height=0.7,
            width=0.7,
            x=0.15,
            y=0.15,
            on_focus_lost_hide=True
        ),
        DropDown(
            "wallpaperchanger",
            terminal + " -e sh -c '~/.config/qtile/scripts/wallpaper-changer.sh'",
            opacity=0.9,
            height=0.7,
            width=0.7,
            x=0.15,
            y=0.15,
            on_focus_lost_hide=True
        ),
        DropDown(
            "keybinds",
            terminal + "-e sh -c '~/.config/qtile/scripts/keybind.sh",
            opacity=0.9,
            height=0.7,
            width=0.7,
            x=0.15,
            y=0.15,
            on_focus_lost_hide=True
        ),
    ])
)

# Create key bindings for groups
for name, kwargs in group_names:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key(
            [mod],
            name,
            lazy.group[name].toscreen(),
            desc=f"Switch to group {name}"
        ),
        # mod1 + shift + letter of group = move focused window to group
        Key(
            [mod, "shift"],
            name,
            lazy.window.togroup(name, switch_group=True),
            desc=f"Move focused window to group {name}"
        ),
    ])

layouts = [
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(**current_theme['layout_theme']),
    # layout.Matrix(),
    # layout.MonadThreeCol(),
    # layout.Plasma(),
    # layout.RatioTile(),
    # layout.Slice(),
    # layout.Spiral(),
    # layout.Stack(**current_theme['layout_theme']),
    # layout.Stack(num_stacks=2),
    # layout.Tile(**current_theme['layout_theme']),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    # layout.MonadWide(**current_theme['layout_theme']),
    layout.TreeTab(
        **current_theme['layout_theme'],
        panel_width = 120,
        place_right = True,
        sections = ["terminal", "file manager", "editor"],
    ),
    layout.MonadTall(
        **current_theme['layout_theme'],
        change_ratio = 0.07
    ),
    layout.Max(**current_theme['layout_theme']),
]

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayout(
                #     **widget_defaults,
                # ),
                widget.GroupBox(
                    **widget_defaults,
                    highlight_method='block',
                    padding=5,
                    rounded=False,
                    spacing=5,
                    disable_drag=True,
                    active=current_theme['widget_theme']['active'],
                    inactive=current_theme['widget_theme']['inactive'],
                    block_highlight_text_color=current_theme['widget_theme']['block_highlight_text_color'],
                    this_current_screen_border=current_theme['widget_theme']['this_current_screen_border'],
                    **border_decor,
                ),
                #widget.Spacer(length=30),
                widget.WindowName(
                    **widget_defaults,
                    max_chars=90,
                    markup=False,
                    #parse_text=lambda text: text.split(" - ")[-1] if " - " in text else text,
                 ),
                # widget.TaskList(
                #     **widget_defaults,
                #     **powerline_border_status,
                #     stretched=False,
                # ),
                widget.Volume(
                    **widget_defaults,
                    **border_decor,
                    fmt=" 󰕾  {} ",
                ),
                widget.CPU(
                    **widget_defaults,
                    **border_decor,
                    format="󰻠 {freq_current}GHz {load_percent}% ",
                ),
                widget.ThermalSensor(
                    **widget_defaults,
                    **border_decor,
                    padding=0,
                    update_interval=1,
                    format="  {temp:.0f}{unit} ",
                ),
                widget.Memory(
                    **widget_defaults,
                    **border_decor,
                    padding=5,
                    format="󰍛 {MemUsed:.0f}{mm} ",
                ),
                widget.Clock(
                    **widget_defaults,
                    **border_decor,
                    format=" %a %m-%d-%Y %I:%M %p ",
                ),
                widget.Sep(
                    padding=20,
                ),
                widget.CurrentLayoutIcon(
                    padding=3,
                    scale=0.5,
                ),
                #widget.Spacer(length=4),
                widget.QuickExit(
                    **widget_defaults,
                    default_text = "",
                    countdown_format='{}',
                ),
                widget.Spacer(length=5),
            ],
            28,
            # margin=10,
            opacity=current_theme['widget_theme']['panel_opacity'],
            background=current_theme['widget_theme']['background'],
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=current_theme['layout_theme']['border_focus'],
    border_normal=current_theme['layout_theme']['border_normal'],
    border_width=current_theme['layout_theme']['border_width'],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

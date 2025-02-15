import os, psutil
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# from libqtile.utils import guess_terminal

# from qtile_extras import widget
# from qtile_extras.widget.decorations import PowerLineDecoration, BorderDecoration
# import custom config
from custom_colors import *
from utils.volume_notification import show_volume_notification

from themes.theme_manager import ThemeManager
theme_manager = ThemeManager()
current_theme = theme_manager.get_current_theme()

@hook.subscribe.startup_once
def autostart():
    # home = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    home = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    subprocess.Popen([home])

mod = "mod4"

# terminal = guess_terminal()
terminal = "wezterm"

# fonts
mono_fur_font_bold   = "MonofurNerdFont Bold"
mono_fur_font        = "MonofurNerdFont"
jetbarins_font       = "JetBrainsMono Nerd Font Propo Light"
terminess_font       = "Terminess Nerd Font Mono"
jetbarins_bold_font  = "JetBrainsMono Nerd Bold"
small_ft             = 16

# qtile extras
# powerline_border_status = {
#     "decorations": [BorderDecoration(
#         colour = kanagawa_statusline2,
#         # colour = catppuccin_color_blue,
#         border_width = [0, 0, 3, 0],                                            # Underlined style
#         padding_x = 5,
#         padding_y = None,
#     )]
# }

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
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
    # Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.prev_layout(), desc="Toggle between layouts"),

    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Key([mod], "Tab", lazy.screen.next_group(), desc="Toggle between groups"),
    # Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
    Key([mod], "o", lazy.screen.next_group(), desc="Go to next group"),
    Key([mod], "i", lazy.screen.prev_group(), desc="Go to previous group"),
    Key([mod], "Tab",  lazy.screen.toggle_group(), desc="Move to the last visited group"),

    # Minimize layout
    # Key(["mod"], "Tab", lazy.window.toggle_minimize()),  # Switch to previous window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # if there is a prompt widget, activate this line of code
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # toggle fullscreen
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    # launch rofi
    Key(
        [mod],
        "d",
        lazy.spawn(
            # "rofi -modi drun -show drun \ -config ~/.config/rofi/rofidmenu.rasi"
            "rofi -modi drun -show drun"
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
    # emacs
    Key(
        [mod],
        "e",
        lazy.group["3"].toscreen(toggle=False),
        lazy.spawn("emacsclient -c -a 'emacs'"),
        desc="Launch Emacs client",
    ),
    # browser
    Key(
        [mod],
        "b",
        lazy.group["9"].toscreen(toggle=False),
        lazy.spawn("vivaldi-stable"),
        desc="Launch vivaldi browser",
    ),
    # ranger
    Key(
        [mod],
        "n",
        lazy.group["1"].toscreen(toggle=False),
        lazy.spawn("wezterm cli spawn  -- ranger"),
        desc="Launch File Manager",
    ),
    Key(
        [mod, "shift"],
        "n",
        lazy.group["1"].toscreen(toggle=False),
        lazy.spawn("wezterm cli spawn --new-window -- ranger"),
        desc="Launch File Manager",
    ),
    Key(
        [mod],
        "g",
        lazy.group["1"].toscreen(toggle=False),
        lazy.spawn("wezterm cli spawn -- lazygit"),
        desc="Launch File Manager",
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
        [mod, "control"], "p", lazy.spawn(".config/qtile/scripts/powermenu.sh"), desc="Launch PowerMenu",
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
    # using dunstify
    # Key([], "XF86AudioRaiseVolume",
    #     lazy.spawn("amixer set Master 1%+ && volume=$(amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }') && dunstify -t 2000 'Volume' \"$volume%\""),
    #     desc="Increase volume"
    # ),
    # Key([], "XF86AudioLowerVolume",
    #     lazy.spawn("amixer set Master 1%- && volume=$(amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }') && dunstify -t 2000 'Volume' \"$volume%\""),
    #     desc="Decrease volume"
    # ),
    # Key([], "XF86AudioMute",
    #     lazy.spawn("amixer set Master toggle && volume=$(amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }') && dunstify -t 2000 'Volume' \"$volume%\""),
    #     desc="Mute volume"
    # ),
    # Focus the last window (similar to bspc node -f last)
    # Key(["mod4"], "Tab", lazy.group.prev_window(), desc="Focus last window"),
    # Key(["mod4"], "Tab", lazy.group.prev_window(), desc="Focus last window"),
]

group_names = [
    ("1", {"layout": "MonadTall",  "label": "I",    "matches": [Match(wm_class="Wezterm")]                 }),
    ("1", {"layout": "max",        "label": "I",    "matches": [Match(wm_class="jetbrains-studio")]        }),
    ("2", {"layout": "columns",    "label": "II" ,  "matches": [Match(wm_class="firefox")]                 }),
    ("2", {"layout": "columns",    "label": "I" ,   "matches": [Match(wm_class="qutebrowser")]             }),
    ("2", {"layout": "columns",    "label": "II",   "matches": [Match(wm_class="vivaldi-stable")]          }),
    ("3", {"layout": "max",        "label": "III",  "matches": [Match(wm_class="Emacs")]                   }),
    ("3", {"layout": "max",        "label": "III",  "matches": [Match(wm_class="obsidian")]                }),
    ("4", {"layout": "max",        "label": "IV",   "matches": [Match(wm_class="AppFlowy")]                }),
    ("5", {"layout": "columns",    "label": "V",    "matches": [Match(wm_class="gwenview")]                }),
    ("5", {"layout": "columns",    "label": "X",    "matches": [Match(wm_class="dolphin")]                 }),
    ("6", {"layout": "columns",    "label": "VI",   "matches": [Match(wm_class="logseq")]                  }),
    ("6", {"layout": "columns",    "label": "VI",   "matches": [Match(wm_class="Joplin")]                  }),
    ("7", {"layout": "max",        "label": "VII",  "matches": [Match(wm_class="gimp-2.10")]               }),
    ("7", {"layout": "max",        "label": "VI" ,  "matches": [Match(wm_class="krita")]                   }),
    ("7", {"layout": "max",        "label": "VI" ,  "matches": [Match(wm_class="libresprite")]             }),
    ("8", {"layout": "max",        "label": "VIII", "matches": [Match(wm_class="Blender")]                 }),
    ("9", {"layout": "max",        "label": "IX",   "matches": [Match(wm_class="Houdini FX")]              }),
    ("0", {"layout": "max",        "label": "X" ,   "matches": [Match(wm_class="Godot")]                   }),
    ("0", {"layout": "max",        "label": "X" ,   "matches": [Match(wm_class="com.defold.editor.Start")] }),
]

# Create groups with labels
groups = [Group(name, **kwargs) for name, kwargs in group_names]


# Create groups from the group_names list
groups = [Group(name, **kwargs) for name, kwargs in group_names]


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
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(**current_theme['layout_theme']),
    layout.MonadWide(**current_theme['layout_theme']),
    # layout.RatioTile(),
    # layout.Tile(**current_theme['layout_theme']),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    # layout.MonadTall(**current_theme['layout_theme']),  # For terminal
    layout.Max(**current_theme['layout_theme']),        # For coding in Android Studio
    layout.Columns(**current_theme['layout_theme']),    # For image editing and file manager
]

# Define widget defaults using current theme
widget_defaults = dict(
    font=terminess_font,
    fontsize=small_ft,
    foreground=current_theme['widget_theme']['foreground'],
    background=current_theme['widget_theme']['background'],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    **widget_defaults,
                    highlight_method='block',
                    padding=3,
                    rounded=False,
                    spacing=5,
                    disable_drag=True,
                    active=current_theme['widget_theme']['active'],
                    inactive=current_theme['widget_theme']['inactive'],
                    block_highlight_text_color=current_theme['widget_theme']['block_highlight_text_color'],
                    this_current_screen_border=current_theme['widget_theme']['this_current_screen_border'],
                ),
                widget.Spacer(length=50),
                widget.WindowName(
                    **widget_defaults,
                    max_chars=90,
                    #parse_text=lambda text: text.split(" - ")[-1] if " - " in text else text,
                ),
                widget.Volume(
                    **widget_defaults,
                    fmt="󰕾  {} ",
                ),
                widget.CPU(
                    **widget_defaults,
                    format="CPU: {freq_current}GHz {load_percent}% ",
                ),
                widget.ThermalSensor(
                    **widget_defaults,
                    padding=0,
                    update_interval=1,
                    format="Temp: {temp:.0f}{unit} ",
                ),
                widget.Memory(
                    **widget_defaults,
                    padding=5,
                    format="Mem: {MemUsed:.0f}{mm} ",
                ),
                widget.Clock(
                    **widget_defaults,
                    format="%a %m-%d-%Y %I:%M %p ",
                ),
                widget.CurrentLayoutIcon(padding=3),
            ],
            25,
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

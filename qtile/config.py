import os
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# import custom config
from custom_colors import *


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    subprocess.Popen([home])


mod = "mod4"

terminal = "wezterm"

# fonts
mono_fur_font_bold = "MonofurNerdFont Bold"
mono_fur_font = "MonofurNerdFont"
small_ft = 16


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
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "o", lazy.screen.next_group(), desc="Go to next group"),
    Key([mod], "i", lazy.screen.prev_group(), desc="Go to previous group"),
    Key(
        [mod], "Tab", lazy.screen.toggle_group(), desc="Move to the last visited group"
    ),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
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
            "rofi -modi drun -show drun \ -config ~/.config/rofi/rofidmenu.rasi"
        ),
    ),
    # launch terminal
    Key(
        [mod],
        "Return",
        lazy.group["2"].toscreen(toggle=False),
        lazy.spawn(terminal),
        desc="Launch terminal",
    ),
    # file manager
    Key(
        [mod],
        "e",
        lazy.group["3"].toscreen(toggle=False),
        lazy.spawn("emacs"),
        desc="Launch Emacs",
    ),
    # browser
    Key(
        [mod],
        "b",
        lazy.group["9"].toscreen(toggle=False),
        lazy.spawn("vivaldi-stable"),
        desc="Launch vivaldi browser",
    ),
    Key(
        [mod],
        "n",
        lazy.group["0"].toscreen(toggle=False),
        lazy.spawn("dolphin"),
        desc="Launch File Manager",
    ),
    # screen shot
    Key(
        [],
        "Print",
        lazy.spawn(".config/qtile/scripts/screenshot.sh"),
        desc="Printscreen",
    ),
    # lock
    Key([mod, "shift"], "p", lazy.spawn("i3lock"), desc="LockScreen"),
    # Volume control
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("amixer set Master 1%+"),
        desc="Increase volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("amixer set Master 1%-"),
        desc="Decrease volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("amixer set Master toggle"),
        desc="Mute volume",
    ),
]

group_names = [
    ("1", {"layout": "max", "label": "o", "matches": [Match(wm_class="qutebrowser")]}),
    ("1", {"layout": "max", "label": "o", "matches": [Match(wm_class="krita")]}),
    ("1", {"layout": "max", "label": "o", "matches": [Match(wm_class="Blender")]}),
    ("1", {"layout": "max", "label": "o", "matches": [Match(wm_class="libresprite")]}),
    ("1", {"layout": "max", "label": "o", "matches": [Match(wm_class="Godot")]}),
    ("1", {"layout": "max", "label": "o", "matches": [Match(wm_class="Houdini FX")]}),
    (
        "1",
        {
            "layout": "max",
            "label": "o",
            "matches": [Match(wm_class="com.defold.editor.Start")],
        },
    ),
    ("2", {"layout": "max", "label": "o", "matches": [Match(wm_class="Alacritty")]}),
    ("3", {"layout": "max", "label": "o", "matches": [Match(wm_class="Emacs")]}),
    ("4", {"layout": "max", "label": "o", "matches": [Match(wm_class="obsidian")]}),
    ("5", {"layout": "columns", "label": "o", "matches": [Match(wm_class="logseq")]}),
    (
        "6",
        {
            "layout": "max",
            "label": "o",
            "matches": [Match(wm_class="jetbrains-studio")],
        },
    ),
    ("7", {"layout": "max", "label": "o", "matches": [Match(wm_class="gimp-2.10")]}),
    ("8", {"layout": "columns", "label": "o", "matches": [Match(wm_class="gwenview")]}),
    (
        "9",
        {"layout": "max", "label": "o", "matches": [Match(wm_class="vivaldi-stable")]},
    ),
    ("0", {"layout": "max", "label": "o", "matches": [Match(wm_class="dolphin")]}),
]

# Create groups with labels
groups = [Group(name, **kwargs) for name, kwargs in group_names]


# Create groups from the group_names list
groups = [Group(name, **kwargs) for name, kwargs in group_names]


# Create key bindings for groups
for name, kwargs in group_names:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod], name, lazy.group[name].toscreen(), desc=f"Switch to group {name}"
            ),
            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                name,
                lazy.window.togroup(name, switch_group=True),
                desc=f"Move focused window to group {name}",
            ),
        ]
    )


layout_theme = {
    "border_width": 3,
    "margin": 3,
    "border_focus": neonpunk_001_lavender,
    "border_normal": neonpunk_001_indigo,
}
layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    # layout.MonadTall(**layout_theme),  # For terminal
    layout.Max(**layout_theme),  # For coding in Android Studio
    layout.Columns(**layout_theme),  # For image editing and file manager
]

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font=mono_fur_font,
                    fontsize=small_ft,
                    padding=3,
                    inactive=neonpunk_primary_lavender,
                    highlight_method="block",
                    rounded=True,
                    block_highlight_text_color=neonpunk_base_port_gore,
                    this_current_screen_border=neonpunk_primary_indigo,
                    foreground=neonpunk_primary_lavender,
                    background=neonpunk_base_port_gore,
                    disable_drag=True,
                ),
                widget.Spacer(
                    length=30,
                ),
                widget.WindowName(
                    font=mono_fur_font,
                    fontsize=small_ft,
                    max_chars=90,
                    foreground=txt_color_light,
                ),
                widget.Volume(
                    font=mono_fur_font,
                    fontsize=small_ft,
                    foreground=neonpunk_primary_lavender,
                    fmt="󰕾  {} ",
                ),
                widget.CPU(
                    font=mono_fur_font,
                    fontsize=small_ft,
                    foreground=neonpunk_primary_malibu,
                    format="CPU: {freq_current}GHz {load_percent}% ",
                ),
                widget.ThermalSensor(
                    font=mono_fur_font,
                    fontsize=small_ft,
                    foreground=neonpunk_primary_lavender,
                    padding=0,
                    update_interval=1,
                    format="Temp: {temp:.0f}{unit} ",
                ),
                widget.Memory(
                    font=mono_fur_font_bold,
                    fontsize=small_ft,
                    foreground=neonpunk_primary_malibu,
                    padding=5,
                    format="Mem: {MemUsed:.0f}{mm} ",
                ),
                widget.Clock(
                    font=mono_fur_font,
                    fontsize=small_ft,
                    foreground=neonpunk_primary_lavender,
                    format="%a %m-%d-%Y %I:%M %p ",
                ),
                widget.CurrentLayoutIcon(
                    padding=3,
                ),
            ],
            25,
            opacity=neonpunk_opacity_panel,
            background=neonpunk_base_port_gore,
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

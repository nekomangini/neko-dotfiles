# Qtile Configuration for NixOS - Dual Monitor Setup
import os
import subprocess
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule
from libqtile.lazy import lazy


mod = "mod4"
terminal = "kitty"
doom = "emacsclient -c -s 'nekoserver'"

# Colors (Solarized)
colors = {
    "bg": "#002b36",
    "fg": "#839496",
    "red": "#dc322f",
    "green": "#859900",
    "yellow": "#b58900",
    "blue": "#268bd2",
    "purple": "#d33682",
    "aqua": "#2aa198",
    "orange": "#cb4b16",
    "gray": "#586e75",
    "bg1": "#073642",
    "bg2": "#586e75",
}

# ===== MULTI MONITOR SETUP =====
# Groups with screen affinity matching Hyprland setup
# Monitor 1 (HDMI-A-1 / 32"): 1, 3, 4, 6
# Monitor 0 (DVI-D-1 / 22"):  2, 5, 7, 8, 9, 10
groups = [
    # Monitor 1 (HDMI-A-1 - 32" - Secondary)
    Group(
        "1", 
        label="1:ᜀ",  # Terminal
        screen_affinity=1,
        layout="max",
        matches=[
            Match(wm_class="kitty"),
        ]
    ),
    Group(
        "3", 
        label="3:ᜄ᜔",  # Emacs/Dev
        screen_affinity=1,
        layout="max",
        matches=[
            Match(wm_class="Emacs"),
            Match(wm_class="dev.zed.Zed"),
            Match(wm_class="jetbrains-studio"),
        ]
    ),
    Group(
        "4", 
        label="4:ᜏ",  # Docs/Browser
        screen_affinity=1,
        layout="monadtall",
        matches=[
            Match(wm_class="Brave-browser"),
            Match(wm_class="obsidian"),
            Match(wm_class="okular"),
        ]
    ),
    Group(
        "6", 
        label="6:ᜉᜓ",  # Files
        screen_affinity=1,
        layout="monadtall",
        matches=[
            Match(wm_class="gwenview"),
            Match(wm_class="dolphin"),
        ]
    ),
    
    # Monitor 0 (DVI-D-1 - 22" - Primary)
    Group(
        "2", 
        label="2:ᜅ᜔",  # Browser
        screen_affinity=0,
        layout="monadtall",
        matches=[
            Match(wm_class="vivaldi-stable"),
        ]
    ),
    Group(
        "5", 
        label="5:ᜉᜓ",  # Task/PKMS
        screen_affinity=0,
        layout="monadwide",
        matches=[
            Match(wm_class="ticktick"),
            Match(wm_class="Logseq"),
            Match(wm_class="Joplin"),
        ]
    ),
    Group(
        "7", 
        label="7:ᜃᜓ",  # Blender
        screen_affinity=0,
        layout="max",
        matches=[
            Match(wm_class="Blender"),
        ]
    ),
    Group(
        "8", 
        label="8:ᜆ",  # Houdini
        screen_affinity=0,
        layout="max",
        matches=[
            Match(wm_class="Houdini FX"),
        ]
    ),
    Group(
        "9", 
        label="9:ᜎ",  # 2D Art
        screen_affinity=0,
        layout="max",
        matches=[
            Match(wm_class="gimp-3.0"),
            Match(wm_class="krita"),
            Match(wm_class="libresprite"),
        ]
    ),
    Group(
        "0", 
        label="10:ᜄ",  # Game Dev
        screen_affinity=0,
        layout="max",
        matches=[
            Match(wm_class="Godot"),
            Match(wm_class="com.defold.editor.Start"),
        ]
    ),
]

# Function to go to group with proper screen handling
def go_to_group(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.groups_map[name].toscreen()
            return

        # Monitor 0 (DVI-D-1): groups 2, 5, 7, 8, 9, 10
        if name in '257890':
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        # Monitor 1 (HDMI-A-1): groups 1, 3, 4, 6
        else:
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner

# Function to move window to group and follow
def go_to_group_and_move_window(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.current_window.togroup(name, switch_group=True)
            return

        # Monitor 0 (DVI-D-1): groups 2, 5, 7, 8, 9, 10
        if name in "257890":
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        # Monitor 1 (HDMI-A-1): groups 1, 3, 4, 6
        else:
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner

# Keybindings
keys = [
    # ===== WINDOW MANAGEMENT =====
    # Move focus with hjkl
    Key([mod], "h", lazy.layout.left(),  desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(),  desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(),    desc="Move focus up"),
    
    # Swap windows with Shift + hjkl
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),  desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),  desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),    desc="Move window up"),
    
    # Resize with Control + hjkl
    Key([mod, "control"], "h", lazy.layout.grow_left(),  desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),  desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),    desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(),             desc="Reset all window sizes"),
    
    # Window actions
    Key([mod], "q", lazy.window.kill(),              desc="Kill focused window"),
    Key([mod], "v", lazy.window.toggle_floating(),   desc="Toggle floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "t", lazy.layout.toggle_split(),      desc="Toggle split"),
    Key([mod], "x", lazy.window.toggle_minimize(),   desc="Toggle minimize (pseudo)"),
    
    # Cycle through windows
    Key([mod], "w", lazy.spawn("rofi -show window"), desc="Select window"),
    
    # ===== LAUNCH APPLICATIONS =====
    Key([mod], "Return", lazy.spawn(terminal),                                                desc="Launch terminal"),
    Key([mod, "control"], "Return", lazy.spawn(f"{terminal} -e tmux new-session -A -s main"), desc="Launch tmux"),
    Key([mod], "d", lazy.spawn("rofi -show drun"),                                            desc="Launch rofi"),
    Key([mod], "e", lazy.spawn(doom),                                                         desc="Launch Emacs"),
    
    # Scripts (adjust paths as needed)
    Key([mod], "p", lazy.spawn(os.path.expanduser("~/neko-dotfiles/modules/home-manager/qtile/config/scripts/powermenu.raku")), desc="Power menu"),
    
    # ===== LAYOUT MANAGEMENT =====
    Key([mod], "space", lazy.next_layout(),             desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.prev_layout(),    desc="Toggle between layouts"),
    Key([mod], "backslash", lazy.screen.toggle_group(), desc="Toggle to previous workspace"),
    Key([mod], "Tab", lazy.screen.toggle_group(),       desc="Toggle to previous workspace"),
    
    # ===== WORKSPACE NAVIGATION =====
    Key([mod], "o", lazy.screen.next_group(skip_empty=True), desc="Move to next workspace"),
    Key([mod], "i", lazy.screen.prev_group(skip_empty=True), desc="Move to previous workspace"),
    
    # ===== QTILE SYSTEM =====
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(),      desc="Shutdown Qtile"),
    
    # ===== MULTIMEDIA KEYS =====
    # Volume controls
    Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), desc="Volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      desc="Volume down"),
    Key([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),            desc="Mute"),
    # Key([], "XF86AudioMicMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), desc="Mute mic"),
    
    # Brightness controls
    # Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -e4 -n2 set 5%+"), desc="Brightness up"),
    # Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -e4 -n2 set 5%-"), desc="Brightness down"),
    
    # Media controls
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"),        desc="Next track"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"),    desc="Previous track"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"),  desc="Play/Pause"),
    Key([], "XF86AudioPause", lazy.spawn("playerctl play-pause"), desc="Play/Pause"),
    
    # ===== SCREENSHOTS =====
    # DVI monitor
    Key([], "Print",
        lazy.spawn(os.path.expanduser("~/neko-dotfiles/modules/home-manager/qtile/config/scripts/screenshot.raku DVI")),
        desc="Screenshot DVI monitor"
    ),
    # HDMI monitor
    Key(["shift"], "Print",
        lazy.spawn(os.path.expanduser("~/neko-dotfiles/modules/home-manager/qtile/config/scripts/screenshot.raku HDMI")),
        desc="Screenshot HDMI monitor"
    ),
    # Both monitors
    Key(["control"], "Print",
        lazy.spawn(os.path.expanduser("~/neko-dotfiles/modules/home-manager/qtile/config/scripts/screenshot.raku BOTH")),
        desc="Screenshot Both monitors"
    ),

    # ===== MOUSE EMULATION =====
    # Mouse movement with Super+Alt+hjkl
    Key([mod, "mod1"], "h", lazy.spawn("xdotool mousemove_relative -- -20 0")),   # Left
    Key([mod, "mod1"], "j", lazy.spawn("xdotool mousemove_relative -- 0 20")),    # Down
    Key([mod, "mod1"], "k", lazy.spawn("xdotool mousemove_relative -- 0 -20")),   # Up
    Key([mod, "mod1"], "l", lazy.spawn("xdotool mousemove_relative -- 20 0")),    # Right

    # Mouse clicks
    Key([mod, "mod1"], "space",  lazy.spawn("xdotool click 1")),   # Left click
    Key([mod, "mod1"], "Return", lazy.spawn("xdotool click 3")),   # Right click

    # Diagonal movements
    Key([mod, "mod1"], "u", lazy.spawn("xdotool mousemove_relative -- -40 -40")), # Up-Left
    Key([mod, "mod1"], "i", lazy.spawn("xdotool mousemove_relative -- 40 -40")),  # Up-Right
    Key([mod, "mod1"], "n", lazy.spawn("xdotool mousemove_relative -- -40 40")),  # Down-Left
    Key([mod, "mod1"], "m", lazy.spawn("xdotool mousemove_relative -- 40 40")),   # Down-Right

    # ===== MULTI MONITOR SETUP =====
    # ===== MONITOR NAVIGATION =====
    Key([mod], "comma", lazy.to_screen(0),                 desc="Focus monitor 0 (DVI-D-1)"),
    Key([mod], "period", lazy.to_screen(1),                desc="Focus monitor 1 (HDMI-A-1)"),
    Key([mod, "shift"], "comma", lazy.window.toscreen(0),  desc="Move window to monitor 0"),
    Key([mod, "shift"], "period", lazy.window.toscreen(1), desc="Move window to monitor 1"),
    
    # Swap workspaces between monitors
    # TODO:
    # Key([mod, "control"], "period", lazy.screen.toggle_group(), desc="Swap active workspaces"),
]

# ===== MULTI MONITOR SETUP =====
# Add group keybindings with proper screen handling
for i in groups:
    keys.extend([
        # Switch to group
        Key([mod], i.name, lazy.function(go_to_group(i.name)), desc=f"Switch to group {i.name}"),
        # Move window to group
        Key([mod, "shift"], i.name, lazy.function(go_to_group_and_move_window(i.name)), desc=f"Move to group {i.name}"),
    ])

# Layouts
layouts = [
    layout.Max(
        margin=7
    ),
    layout.MonadTall(
        border_focus=colors["orange"],
        border_normal=colors["bg2"],
        border_width=3,
        margin=7,
    ),
    layout.MonadWide(
        border_focus=colors["orange"],
        border_normal=colors["bg2"],
        border_width=3,
        margin=7,
    ),
    # layout.Columns(
    #     border_focus=colors["orange"],
    #     border_normal=colors["bg2"],
    #     border_width=3,
    #     margin=7,
    # ),
    # layout.Floating(
    #     border_focus=colors["orange"],
    #     border_normal=colors["bg2"],
    #     border_width=3,
    # ),
]

# Widget defaults
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=3,
    background=colors["bg"],
    foreground=colors["fg"],
)
extension_defaults = widget_defaults.copy()

# ===== MULTI MONITOR SETUP =====
# Create widgets for each screen
def create_widgets(monitor=0):
    """Create widget list for each monitor with proper GroupBox filtering"""
    # Determine which groups to show on this monitor
    if monitor == 0:
        # DVI-D-1 (22" - Primary)
        visible_groups = ['2', '5', '7', '8', '9', '0']
    else:
        # HDMI-A-1 (32" - Secondary)
        visible_groups = ['1', '3', '4', '6']
    
    widgets = [
        widget.Sep(
            linewidth=0,
            padding=6,
        ),
        widget.CurrentLayout(
            scale=0.65,
            padding=8,
            foreground=colors["orange"],
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors["gray"],
        ),
        widget.GroupBox(
            active=colors["fg"],
            inactive=colors["gray"],
            highlight_method="line",
            highlight_color=[colors["bg"], colors["bg1"]],
            this_current_screen_border=colors["orange"],
            this_screen_border=colors["blue"],
            other_current_screen_border=colors["yellow"],
            other_screen_border=colors["gray"],
            urgent_border=colors["red"],
            borderwidth=3,
            padding_x=8,
            padding_y=5,
            fontsize=16,
            visible_groups=visible_groups,
            disable_drag=True,
            hide_unused=False,  # Show all groups even if empty
            urgent_alert_method='line',
            use_mouse_wheel=False,
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors["gray"],
        ),
        widget.WindowName(
            foreground=colors["aqua"],
            max_chars=50,
            format="{name}",
            padding=8,
        ),
        widget.Spacer(),
        # CPU Temperature
        widget.ThermalSensor(
            format=" {temp:.1f}{unit}",
            foreground=colors["green"],
            foreground_alert=colors["red"],
            threshold=80,
            tag_sensor="Core 0",
            update_interval=2,
            padding=8,
        ),
        # GPU Temperature
        widget.NvidiaSensors(
            format="󰢮 {temp}°C  {fan_speed}%",
            foreground=colors["aqua"],
            foreground_alert=colors["red"],
            threshold=75,
            update_interval=2,
            padding=8,
        ),
        widget.CPU(
            format="󰻠  {load_percent}%",
            foreground=colors["green"],
            update_interval=2,
            padding=8,
        ),
        widget.Memory(
            format="󰍛  {MemUsed:.0f}{mm}",
            foreground=colors["blue"],
            padding=8,
        ),
        widget.PulseVolume(
            fmt="󰕾 {}",
            foreground=colors["purple"],
            padding=8,
        ),
        widget.Clock(
            format="%Y-%m-%d %I:%M",
            foreground=colors["orange"],
            padding=8,
        ),
    ]
    
    widgets.append(
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors["gray"],
        )
    )

    # Only add systray to primary monitor (DVI-D-1)
    if monitor == 0:
        widgets.append(
            widget.Systray(
                padding=8,
            )
        )
    
    
    widgets.append(
        widget.QuickExit(
            default_text="⏻",
            countdown_format="[{}]",
            foreground=colors["red"],
            fontsize=16,
            padding=8,
        )
    )
    
    widgets.append(
        widget.Sep(
            linewidth=0,
            padding=6,
        )
    )
    
    return widgets

# ===== MULTI MONITOR SETUP =====
# Screens - Create bar for each monitor
screens = [
    # Monitor 0: DVI-D-1 (22" - Primary)
    Screen(
        top=bar.Bar(
            create_widgets(monitor=0),
            26,
            background=colors["bg"],
            opacity=0.95,
            margin=[7, 7, 0, 7],  # top, right, bottom, left
        ),
    ),
    # Monitor 1: HDMI-A-1 (32" - Secondary)
    Screen(
        top=bar.Bar(
            create_widgets(monitor=1),
            26,
            background=colors["bg"],
            opacity=0.95,
            margin=[7, 7, 0, 7],
        ),
    ),
]

# ===== MULTI MONITOR SETUP =====
# Hook to handle dynamic screen reconfiguration
# TODO:
@hook.subscribe.screens_reconfigured
async def _():
    """Handle screen reconfiguration (plugging/unplugging monitors)"""
    if len(qtile.screens) == 1:
        # Single monitor mode - show all groups
        for screen in qtile.screens:
            if hasattr(screen, 'top'):
                for w in screen.top.widgets:
                    if isinstance(w, widget.GroupBox):
                        w.visible_groups = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
                        if hasattr(w, 'bar'):
                            w.bar.draw()

# Mouse bindings
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# Window rules
dgroups_key_binder = None
# dgroups_app_rules = [
#     # Monitor 1 (HDMI-A-1 / 32") - Workspace assignments
#     Rule(Match(wm_class="kitty"),                   group="1"),
#     Rule(Match(wm_class="Emacs"),                   group="3"),
#     Rule(Match(wm_class="dev.zed.Zed"),             group="3"),
#     Rule(Match(wm_class="jetbrains-studio"),        group="3"),
#     Rule(Match(wm_class="brave-browser"),           group="4"),
#     Rule(Match(wm_class="obsidian"),                group="4"),
#     Rule(Match(wm_class="okular"),                  group="4"),
#     Rule(Match(wm_class="gwenview"),                group="6"),
#     Rule(Match(wm_class="dolphin"),                 group="6"),
    
#     # Monitor 0 (DVI-D-1 / 22") - Workspace assignments
#     Rule(Match(wm_class="vivaldi-stable"),          group="2"),
#     Rule(Match(wm_class="ticktick"),                group="5"),
#     Rule(Match(wm_class="Logseq"),                  group="5"),
#     Rule(Match(wm_class="Joplin"),                  group="5"),
#     Rule(Match(wm_class="blender"),                 group="7"),
#     Rule(Match(wm_class="Houdini FX"),              group="8"),
#     Rule(Match(wm_class="gimp-3.0"),                group="9"),
#     Rule(Match(wm_class="krita"),                   group="9"),
#     Rule(Match(wm_class="libresprite"),             group="9"),
#     Rule(Match(wm_class="Godot"),                   group="0"),
#     Rule(Match(wm_class="com.defold.editor.Start"), group="0"),
# ]

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="nm-connection-editor"),
    ],
    border_focus=colors["orange"],
    border_normal=colors["bg2"],
    border_width=3,
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"

# Autostart hook
@hook.subscribe.startup_once
def autostart():
    # home = os.path.expanduser("~/neko-dotfiles/modules/home-manager/qtile/config/autostart.sh")
    home = os.path.expanduser("~/neko-dotfiles/modules/home-manager/qtile/config/scripts/autostart.raku")
    subprocess.Popen([home])

# ===== MULTI MONITOR SETUP =====
# TODO:
# Hook to handle fullscreen windows (matching Hyprland behavior)
# @hook.subscribe.client_new
# def fullscreen_apps(client):
#     """Auto-fullscreen specific applications"""
#     fullscreen_classes = [
#         "kitty",
#         "blender", 
#         "Emacs",
#         "jetbrains-studio",
#         "krita",
#     ]
    
#     if client.window.get_wm_class() and any(
#         cls in client.window.get_wm_class() for cls in fullscreen_classes
#     ):
#         client.fullscreen = True

# ===== MULTI MONITOR SETUP =====
# TODO:
# Hook to maximize specific windows
# @hook.subscribe.client_new
# def maximize_apps(client):
#     """Auto-maximize specific applications"""
#     maximize_classes = [
#         "Godot",
#         "libresprite",
#         "Emacs"
#     ]
    
#     if client.window.get_wm_class() and any(
#         cls in client.window.get_wm_class() for cls in maximize_classes
#     ):
#         client.maximized = True

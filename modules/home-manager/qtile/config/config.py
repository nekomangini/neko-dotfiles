# Qtile Configuration for NixOS - Dual Monitor Setup
import os
import subprocess
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule
from libqtile.lazy import lazy


mod = "mod4"
terminal = "kitty"
doom = "emacsclient -c -s 'nekoserver'"

# Colors (Everforest Dark Palette)
colors = {
    "bg":     "#272e33", # Dark forest background
    "fg":     "#d3c6aa", # Warm cream foreground
    "red":    "#e67e80", # Muted terracotta
    "green":  "#a7c080", # Sage green
    "yellow": "#dbbc7f", # Soft amber
    "blue":   "#7fbbb3", # Muted teal/blue
    "purple": "#d699b6", # Dusty mauve
    "aqua":   "#83c092", # Soft aqua
    "orange": "#e69875", # Muted copper
    "gray":   "#859289", # Comforting gray
    "bg1":    "#2e383c", # Slightly lighter for highlights
    "bg2":    "#414b50", # Border/Active window gray
}

# ===== Keybindings =====
keys = [
    # ===== WINDOW MANAGEMENT =====
    # Move focus with hjkl
    Key([mod], "h", lazy.layout.left(),  desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(),  desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(),    desc="Move focus up"),
    
    # Swap windows with Shift + hjkl
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left().when(layout=["monadtall", "monadwide"]),
        desc="Move window to the left"),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right().when(layout=["monadtall", "monadwide"]),
         desc="Move window to the right"),
    Key([mod, "shift"], "j",
         lazy.layout.shuffle_down().when(layout=["monadtall", "verticaltile", "monadwide"]),
         desc="Move window down"),
    Key([mod, "shift"], "k",
         lazy.layout.shuffle_up().when(layout=["monadtall", "verticaltile", "monadwide"]),
         desc="Move window up"),
    
    # Resize with Control + hjkl
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left"),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the right"),
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
    Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), desc="Volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),      desc="Volume down"),
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

# ===== Layouts =====
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
    layout.VerticalTile(
        border_focus=colors["orange"],
        border_normal=colors["bg2"],
        border_width=3,
        margin=5,
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

# ===== GROUPS =====
# Monitor 0 (HDMI-A-1 / 22"): 2, 4
# Monitor 1 (DVI-D-1 / 22"):  1, 3, 5
groups = [
    # Monitor 0 (DVI-D-1 - 22" - Vertical)
    Group(
        "1", 
        label="1",
        screen_affinity=1,
        layout="max",
        matches=[
            Match(wm_class="kitty"),
            Match(wm_class="Emacs"),
            Match(wm_class="dev.zed.Zed"),
            Match(wm_class="jetbrains-studio"),
        ]
    ),
    # Monitor 1 (HDMI-A-1 - 22" - Horizontal)
    Group(
        "2", 
        label="2",
        screen_affinity=0,
        layout="monadtall",
        matches=[
            Match(wm_class="Brave-browser"),
            Match(wm_class="dolphin"),
            Match(wm_class="vivaldi-stable"),
        ]
    ),
    # Monitor 0 (DVI-D-1 - 22" - Vertical)
    Group(
        "3", 
        label="3",
        screen_affinity=1,
        layout="max",
        matches=[
            Match(wm_class="gwenview"),
            Match(wm_class="okular"),
        ]
    ),
    # Monitor 1 (HDMI-A-1 - 22" - Horizontal)
    Group(
        "4", 
        label="4",
        screen_affinity=0,
        layout="max",
        matches=[
            Match(wm_class="Blender"),
            Match(wm_class="krita"),
            Match(wm_class="Godot"),
        ]
    ),
    # Monitor 0 (DVI-D-1 - 22" - Vertical)
    Group(
        "5", 
        label="5",
        screen_affinity=1,
        layout="max",
        matches=[
            Match(wm_class="Logseq"),
            Match(wm_class="Joplin"),
            Match(wm_class="obsidian"),
            Match(wm_class="ticktick"),
        ]
    ),
]

for i in groups:
    keys.extend([
        Key([mod], i.name,
            lazy.group[i.name].toscreen(toggle=False),
            desc=f"Switch to group {i.name}"),
        Key([mod, "shift"], i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc=f"Move window to group {i.name}"),
    ])

# ===== Widget defaults =====
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=3,
    background=colors["bg"],
    foreground=colors["fg"],
)
extension_defaults = widget_defaults.copy()

# Create widgets for each screen
def create_widgets(monitor=0):
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
            format="CPU: {temp:.1f}{unit}",
            foreground=colors["green"],
            foreground_alert=colors["red"],
            threshold=80,
            tag_sensor="Core 0",
            update_interval=2,
            padding=8,
        ),
        # GPU Temperature
        widget.NvidiaSensors(
            format="GPU: {temp}°C  {fan_speed}",
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

# ===== Screens - Create bar for each monitor =====
screens = [
    # Monitor 0: DVI-D-1 (22" - HORIZONTAL)
    Screen(
        top=bar.Bar(
            create_widgets(monitor=0),
            26,
            background=colors["bg"],
            opacity=0.95,
        ),
    ),
    # Monitor 1: HDMI-A-1 (22" - VERTICAL)
    # DON'T DISPLAY THE PANEL BAR
    Screen(),
]

# Mouse bindings
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# Window rules
dgroups_key_binder = None

# Focus behaviour: Mouse moves to active screen; focus follows mouse
cursor_warp = True
follow_mouse_focus = True

bring_front_click = False

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
    home = os.path.expanduser("~/neko-dotfiles/modules/home-manager/qtile/config/scripts/autostart.raku")
    subprocess.Popen([home])

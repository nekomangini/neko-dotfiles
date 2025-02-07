import json
import os
from typing import Dict, Any
from . import kanagawa, nord, catppuccin, neonpunk, gruvbox

class ThemeManager:
    def __init__(self):
        self.themes = {
            'kanagawa': {
                'layout_theme': {
                    'border_width': 3,
                    'margin': 16,
                    'border_focus': kanagawa.kanagawa_yellow,
                    'border_normal': kanagawa.kanagawa_bg_blue,
                },
                'widget_theme': {
                    'background': kanagawa.kanagawa_bg_yellow,
                    'foreground': kanagawa.kanagawa_statusline2,
                    'active': kanagawa.kanagawa_green,
                    'inactive': kanagawa.kanagawa_gray1,
                    'urgent': kanagawa.kanagawa_red,
                    'block_highlight_text_color' : kanagawa.kanagawa_bg_dim,
                    'this_current_screen_border' : kanagawa.kanagawa_green,
                    'panel_opacity': 0.9,
                }
            },
            'nord': {
                'layout_theme': {
                    'border_width': 3,
                    'margin': 12,
                    'border_focus': nord.nord_color_two,
                    'border_normal': nord.nord_color_custom,
                },
                'widget_theme': {
                    'background': nord.nord_color_five,
                    'foreground': nord.nord_status,
                    'active': nord.nord_color_two,
                    'inactive': nord.nord_color_three,
                    'urgent': '#bf616a',
                    'block_highlight_text_color' : nord.nord_text,
                    'this_current_screen_border' : nord.nord_color_one,
                    'panel_opacity': 0.9
                }
            },
            'catppuccin': {
                'layout_theme': {
                    'border_width': 3,
                    'margin': 12,
                    'border_focus': catppuccin.catppuccin_color_blue,
                    'border_normal': catppuccin.catppuccin_color_crust,
                },
                'widget_theme': {
                    'background': catppuccin.catppuccin_color_base,
                    'foreground': catppuccin.catppuccin_color_text,
                    'active': catppuccin.catppuccin_color_green,
                    'inactive': catppuccin.catppuccin_color_overlay_00,
                    'urgent': catppuccin.catppuccin_color_red,
                    'block_highlight_text_color' : catppuccin.catppuccin_color_base,
                    'this_current_screen_border' : catppuccin.catppuccin_color_teal,
                    'panel_opacity': 0.9
                }
            },
            'neonpunk': {
                'layout_theme': {
                    'border_width': 3,
                    'margin': 16,
                    'border_focus': neonpunk.neonpunk_001_lavender,
                    'border_normal': neonpunk.neonpunk_001_indigo,
                },
                'widget_theme': {
                    'background': neonpunk.neonpunk_base_port_gore,
                    'foreground': neonpunk.neonpunk_primary_lavender,
                    'active': neonpunk.neonpunk_primary_malibu,
                    'inactive': neonpunk.neonpunk_primary_indigo,
                    'urgent': neonpunk.neonpunk_accent_red,
                    'block_highlight_text_color' : neonpunk.neonpunk_base_port_gore,
                    'this_current_screen_border' : neonpunk.neonpunk_primary_indigo,
                    'panel_opacity': neonpunk.neonpunk_opacity_panel
                }
            },
            'gruvbox': {
                'layout_theme': {
                    'border_width': 3,
                    'margin': 10,
                    'border_focus': gruvbox.gruvbox_border_active,
                    'border_normal': gruvbox.gruvbox_border_inactive,
                },
                'widget_theme': {
                    'background': gruvbox.gruvbox_bar,
                    'foreground': gruvbox.gruvbox_title_text,
                    'active': gruvbox.gruvbox_active_window,
                    'inactive': gruvbox.gruvbox_inactive_window,
                    'urgent': gruvbox.gruvbox_urgent,
                    'block_highlight_text_color' : gruvbox.gruvbox_text,
                    'this_current_screen_border' : gruvbox.gruvbox_border_bg,
                    'panel_opacity': neonpunk.neonpunk_opacity_panel
                }
            },
        }
        self.theme_file = os.path.expanduser('~/.config/qtile/current_theme.json')

    def get_current_theme(self) -> Dict[str, Any]:
        """Get the current theme configuration"""
        try:
            with open(self.theme_file, 'r') as f:
                theme_name = json.load(f)['theme']
                return self.themes[theme_name]
        except (FileNotFoundError, KeyError, json.JSONDecodeError):
            # Default to neonpunk if no theme is set
            return self.themes['kanagawa']

    def set_theme(self, theme_name: str) -> bool:
        """Set the current theme"""
        if theme_name not in self.themes:
            return False

        with open(self.theme_file, 'w') as f:
            json.dump({'theme': theme_name}, f)
        return True

    def get_available_themes(self) -> list:
        """Get list of available themes"""
        return list(self.themes.keys())

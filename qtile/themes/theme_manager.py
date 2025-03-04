
import json
import os
from typing import Dict, Any
from . import aurora, kanagawa, nord, catppuccin, neonpunk, gruvbox, bloodmoon, cheshirecat, evaasuka

class ThemeManager:
    def __init__(self):
        self.themes = {
            'kanagawa': {
                "layout_theme": {
                    "border_width": 3,
                    'margin': 10,
                    "border_focus": kanagawa.kanagawa_border_active,
                    "border_normal": kanagawa.kanagawa_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": kanagawa.kanagawa_border_active,
                    "active_fg": kanagawa.kanagawa_bar,
                    "inactive_bg": kanagawa.kanagawa_inactive_window,
                    "inactive_fg": kanagawa.kanagawa_text,
                    "urgent_bg": kanagawa.kanagawa_urgent,
                    "urgent_fg": kanagawa.kanagawa_bar,
                    "bg_color": kanagawa.kanagawa_bar,
                    "section_fg": kanagawa.kanagawa_active_window,
                },
                "widget_theme": {
                    "background": kanagawa.kanagawa_bar,
                    "foreground": kanagawa.kanagawa_text,
                    "active": kanagawa.kanagawa_active_window,
                    "inactive": kanagawa.kanagawa_inactive_window,
                    'urgent': kanagawa.kanagawa_urgent,
                    "this_current_screen_border": kanagawa.kanagawa_border_active,
                    "block_highlight_text_color": kanagawa.kanagawa_text,
                    "panel_opacity": 0.9,
                },
            },
            'nord': {
                "layout_theme": {
                    "border_width": 2,
                    'margin': 10,
                    "border_focus": nord.nord_border_active,
                    "border_normal": nord.nord_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": nord.nord_border_active,
                    "active_fg": nord.nord_bar,
                    "inactive_bg": nord.nord_inactive_window,
                    "inactive_fg": nord.nord_text,
                    "urgent_bg": nord.nord_urgent,
                    "urgent_fg": nord.nord_bar,
                    "bg_color": nord.nord_bar,
                    "section_fg": nord.nord_active_window,
                },
                "widget_theme": {
                    "background": nord.nord_bar,
                    "foreground": nord.nord_text,
                    "active": nord.nord_active_window,
                    "inactive": nord.nord_inactive_window,
                    'urgent': nord.nord_urgent,
                    "this_current_screen_border": nord.nord_border_active,
                    "block_highlight_text_color": nord.nord_bar,
                    "panel_opacity": 0.9,
                },
            },
            'catppuccin': {
                "layout_theme": {
                    "border_width": 2,
                    'margin': 10,
                    "border_focus": catppuccin.catppuccin_border_active,
                    "border_normal": catppuccin.catppuccin_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": catppuccin.catppuccin_border_active,
                    "active_fg": catppuccin.catppuccin_bar,
                    "inactive_bg": catppuccin.catppuccin_inactive_window,
                    "inactive_fg": catppuccin.catppuccin_text,
                    "urgent_bg": catppuccin.catppuccin_urgent,
                    "urgent_fg": catppuccin.catppuccin_bar,
                    "bg_color": catppuccin.catppuccin_bar,
                    "section_fg": catppuccin.catppuccin_active_window,
                },
                "widget_theme": {
                    "background": catppuccin.catppuccin_bar,
                    "foreground": catppuccin.catppuccin_text,
                    "active": catppuccin.catppuccin_active_window,
                    "inactive": catppuccin.catppuccin_inactive_window,
                    'urgent': catppuccin.catppuccin_urgent,
                    "this_current_screen_border": catppuccin.catppuccin_border_active,
                    "block_highlight_text_color": catppuccin.catppuccin_bar,
                    "panel_opacity": 0.9,
                },
            },
            'neonpunk': {
                'layout_theme': {
                    'border_width': 3,
                    'margin': 10,
                    'border_focus': neonpunk.neonpunk_border_active,
                    'border_normal': neonpunk.neonpunk_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": neonpunk.neonpunk_border_active,
                    "active_fg": neonpunk.neonpunk_bar,
                    "inactive_bg": neonpunk.neonpunk_inactive_window,
                    "inactive_fg": neonpunk.neonpunk_text,
                    "urgent_bg": neonpunk.neonpunk_urgent,
                    "urgent_fg": neonpunk.neonpunk_bar,
                    "bg_color": neonpunk.neonpunk_bar,
                    "section_fg": neonpunk.neonpunk_active_window,
                },
                "widget_theme": {
                    "background": neonpunk.neonpunk_bar,
                    "foreground": neonpunk.neonpunk_text,
                    "active": neonpunk.neonpunk_active_window,
                    "inactive": neonpunk.neonpunk_inactive_window,
                    'urgent': neonpunk.neonpunk_urgent,
                    "this_current_screen_border": neonpunk.neonpunk_border_active,
                    "block_highlight_text_color": neonpunk.neonpunk_bar,
                    "panel_opacity": 0.7,
                },
            },
            'gruvbox': {
                'layout_theme': {
                    'border_width': 3,
                    'margin': 10,
                    'border_focus': gruvbox.gruvbox_border_active,
                    'border_normal': gruvbox.gruvbox_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": gruvbox.gruvbox_border_active,
                    "active_fg": gruvbox.gruvbox_bar,
                    "inactive_bg": gruvbox.gruvbox_inactive_window,
                    "inactive_fg": gruvbox.gruvbox_text,
                    "urgent_bg": gruvbox.gruvbox_urgent,
                    "urgent_fg": gruvbox.gruvbox_bar,
                    "bg_color": gruvbox.gruvbox_bar,
                    "section_fg": gruvbox.gruvbox_active_window,
                },
                'widget_theme': {
                    'background': gruvbox.gruvbox_bar,
                    'foreground': gruvbox.gruvbox_title_text,
                    'active': gruvbox.gruvbox_active_window,
                    'inactive': gruvbox.gruvbox_inactive_window,
                    'urgent': gruvbox.gruvbox_urgent,
                    'block_highlight_text_color' : gruvbox.gruvbox_text,
                    'this_current_screen_border' : gruvbox.gruvbox_border_bg,
                    'panel_opacity': 0.7
                }
            },
            'aurora': {
                'layout_theme': {
                    'border_width': 3,
                    'margin': 10,
                    #'margin': [10, 5, 10, 5],
                    'border_focus': aurora.aurora_border_active,
                    'border_normal': aurora.aurora_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": aurora.aurora_border_active,
                    "active_fg": aurora.aurora_bar,
                    "inactive_bg": aurora.aurora_inactive_window,
                    "inactive_fg": aurora.aurora_text,
                    "urgent_bg": aurora.aurora_urgent,
                    "urgent_fg": aurora.aurora_bar,
                    "bg_color": aurora.aurora_bar,
                    "section_fg": aurora.aurora_active_window,
                },
                'widget_theme': {
                    'background': aurora.aurora_bar,
                    'foreground': aurora.aurora_title_text,
                    'active': aurora.aurora_active_window,
                    'inactive': aurora.aurora_inactive_window,
                    'urgent': aurora.aurora_urgent,
                    'block_highlight_text_color' : aurora.aurora_bar,
                    'this_current_screen_border' : aurora.aurora_border_bg,
                    'panel_opacity': 0.7
                }
            },
            'bloodmoon': {
                "layout_theme": {
                    "border_width": 2,
                    'margin': 10,
                    "border_focus": bloodmoon.bloodmoon_border_active,
                    "border_normal": bloodmoon.bloodmoon_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": bloodmoon.bloodmoon_border_active,
                    "active_fg": bloodmoon.bloodmoon_bar,
                    "inactive_bg": bloodmoon.bloodmoon_inactive_window,
                    "inactive_fg": bloodmoon.bloodmoon_text,
                    "urgent_bg": bloodmoon.bloodmoon_urgent,
                    "urgent_fg": bloodmoon.bloodmoon_bar,
                    "bg_color": bloodmoon.bloodmoon_bar,
                    "section_fg": bloodmoon.bloodmoon_active_window,
                },
                "widget_theme": {
                    "background": bloodmoon.bloodmoon_bar,
                    "foreground": bloodmoon.bloodmoon_text,
                    "active": bloodmoon.bloodmoon_active_window,
                    "inactive": bloodmoon.bloodmoon_inactive_window,
                    'urgent': bloodmoon.bloodmoon_urgent,
                    "this_current_screen_border": bloodmoon.bloodmoon_border_active,
                    "block_highlight_text_color": bloodmoon.bloodmoon_border_bg,
                    "panel_opacity": 0.9,
                },
            },
            'cheshirecat': {
                "layout_theme": {
                    "border_width": 2,
                    'margin': 10,
                    "border_focus": cheshirecat.cheshirecat_border_active,
                    "border_normal": cheshirecat.cheshirecat_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": cheshirecat.cheshirecat_border_active,
                    "active_fg": cheshirecat.cheshirecat_bar,
                    "inactive_bg": cheshirecat.cheshirecat_inactive_window,
                    "inactive_fg": cheshirecat.cheshirecat_text,
                    "urgent_bg": cheshirecat.cheshirecat_urgent,
                    "urgent_fg": cheshirecat.cheshirecat_bar,
                    "bg_color": cheshirecat.cheshirecat_bar,
                    "section_fg": cheshirecat.cheshirecat_active_window,
                },
                "widget_theme": {
                    "background": cheshirecat.cheshirecat_bar,
                    "foreground": cheshirecat.cheshirecat_text,
                    "active": cheshirecat.cheshirecat_active_window,
                    "inactive": cheshirecat.cheshirecat_inactive_window,
                    'urgent': cheshirecat.cheshirecat_urgent,
                    "this_current_screen_border": cheshirecat.cheshirecat_border_active,
                    "block_highlight_text_color": cheshirecat.cheshirecat_border_bg,
                    "panel_opacity": 0.9,
                },
            },
            'evaasuka': {
                "layout_theme": {
                    "border_width": 3,
                    'margin': 25,
                    "border_focus": evaasuka.evaasuka_border_active,
                    "border_normal": evaasuka.evaasuka_border_inactive,
                    # TreeTab-specific settings
                    "active_bg": evaasuka.evaasuka_border_active,
                    "active_fg": evaasuka.evaasuka_text,
                    "inactive_bg": evaasuka.evaasuka_inactive_window,
                    "inactive_fg": evaasuka.evaasuka_inactive_text,
                    "urgent_bg": evaasuka.evaasuka_urgent,
                    "urgent_fg": evaasuka.evaasuka_bar,
                    "bg_color": evaasuka.evaasuka_bar,
                    "section_fg": evaasuka.evaasuka_active_window,
                },
                "widget_theme": {
                    "background": evaasuka.evaasuka_bar,
                    "foreground": evaasuka.evaasuka_text,
                    "active": evaasuka.evaasuka_active_window,
                    "inactive": evaasuka.evaasuka_inactive_window,
                    'urgent': evaasuka.evaasuka_urgent,
                    "this_current_screen_border": evaasuka.evaasuka_border_active,
                    "block_highlight_text_color": evaasuka.evaasuka_border_bg,
                    "panel_opacity": 0.8,
                },
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

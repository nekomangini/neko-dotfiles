--------------------------------------
--          default config          --
--------------------------------------

-- Pull in the wezterm API
-- local wezterm = require("wezterm")

-- This will hold the configuration.
-- local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Sakura"
-- config.color_scheme = "cyberpunk"
-- config.color_scheme = "rose-pine"

-- and finally, return the configuration to wezterm
-- return config

---------------------------------------------------------------------------------
-- from https://github.com/scottmckendry/Windots/blob/main/wezterm/wezterm.lua --
---------------------------------------------------------------------------------
---
-- Initialize Configuration
---
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 0.91 -- 0.77(qtile) 0.90(awesomewm)
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

---
-- Font
---
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Regular",
	},
	"Segoe UI Emoji",
})
config.font_size = 11

---
-- Window
---
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

---
-- Colors
---
config.force_reverse_video_cursor = true
-- config.color_scheme = "Neon"
-- config.color_scheme = "Neon (terminal.sexy)"
-- config.color_scheme = "Neon Night (Gogh)"
-- config.color_scheme = "Terminix Dark (Gogh)"
-- config.color_scheme = "The Hulk"
-- config.color_scheme = "Galizur"
-- config.color_scheme = "Gruvbox Dark"
config.color_scheme = "GruvboxDarkHard"
-- config.color_scheme = "Gruvbox dark, soft (base16)"
-- config.color_scheme = "Gruvbox dark, pale (base16)"
-- config.color_scheme = "Gruvbox dark, medium (base16)"
-- config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.color_scheme = "nord"
-- config.color_scheme = "Kanagawa (Gogh)"
-- config.color_scheme = "Kanagawa Dragon (Gogh)"
-- config.color_scheme = "kanagawabones"
-- config.color_scheme = "Kasugano (terminal.sexy)"
-- config.color_scheme = "Catppuccin Macchiato" -- Macchiato, Frappe, Latte, Mocha
config.colors = {
	tab_bar = {
		background = transparent_bg, -- Set the background color of the entire tab bar
		new_tab = {
			fg_color = "#16181a", -- Foreground color of new tab button
			bg_color = "#bd5eff", -- Background color of new tab button
		},
		new_tab_hover = {
			fg_color = "#16181a", -- Foreground color when hovering
			bg_color = "#ffffff", -- Background color when hovering
		},
	},
}

---
-- Custom Colors, Custom Tabs
--
-- config.colors = require("cyberdream")
-- config.colors.tab_bar = {
--   background = transparent_bg,
--   new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
--   new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
-- }
-- wezterm.on("format-tab-title", function(tab, _, _, _, hover)
--   local background = config.colors.brights[1]
--   local foreground = config.colors.foreground
--
--   if tab.is_active then
--     background = config.colors.brights[7]
--     foreground = config.colors.background
--   elseif hover then
--     background = config.colors.brights[8]
--     foreground = config.colors.background
--   end
--
--   local title = tostring(tab.tab_index + 1)
--   return {
--     { Foreground = { Color = background } },
--     { Text = "█" },
--     { Background = { Color = background } },
--     { Foreground = { Color = foreground } },
--     { Text = title },
--     { Foreground = { Color = background } },
--     { Text = "█" },
--   }
-- end)

---
-- Shell
---
-- config.default_prog = { "pwsh", "-NoLogo" }

---
-- Tabs
---
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local tab_index = tab.tab_index + 1 -- Add 1 to start numbering from 1 instead of 0
	return string.format(" %d ", tab_index)
end)

----
-- Keybindings
---
-- default keybinds
-- config.keys = {
--   -- Remap paste for clipboard history compatibility
--   { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
-- }
-- config.keys = {
--   { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
-- }
-- config.keys = {
--   { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
-- }

return config

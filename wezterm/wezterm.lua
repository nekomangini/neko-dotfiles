---
-- Initialize Configuration
---
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 0.77 -- 0.77(qtile) 0.90(awesomewm)
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

---
-- Colors
---
config.force_reverse_video_cursor = true
-- config.color_scheme = "Neon"
-- config.color_scheme = "Neon (terminal.sexy)"
-- config.color_scheme = "Neon Night (Gogh)"
-- config.color_scheme = "Terminix Dark (Gogh)"
-- config.color_scheme = "The Hulk"
config.color_scheme = "Galizur"
config.colors = {
  tab_bar = {
    background = transparent_bg, -- Set the background color of the entire tab bar
    new_tab = {
      fg_color = "#16181a",    -- Foreground color of new tab button
      bg_color = "#bd5eff",    -- Background color of new tab button
    },
    new_tab_hover = {
      fg_color = "#16181a", -- Foreground color when hovering
      bg_color = "#ffffff", -- Background color when hovering
    },
  },
}


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

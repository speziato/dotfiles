local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = 'Nord (Gogh)'
config.font = wezterm.font 'Cascadia Code NF'
config.window_frame = {
  font = wezterm.font 'Cascadia Code NF',
  font_size = 12.0,
}
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#4c566a',
      fg_color = '#e5e9f0'
    }
  }
}
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
return config

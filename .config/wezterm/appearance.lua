local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)

  config.color_scheme = "Dracula"
  config.font = wezterm.font "CaskaydiaCove Nerd Font"
  config.font_size = 14.0
  config.macos_window_background_blur = 30
  config.window_background_opacity = 0.80
  config.window_padding = {
      left = 10,
      right = 10,
      top = 10,
      bottom = 10,
  }
  config.initial_cols = 120
  config.initial_rows = 35
end

return module


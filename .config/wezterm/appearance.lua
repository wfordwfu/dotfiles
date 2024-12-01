local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)

  config.color_scheme = "Dracula"
  config.font = wezterm.font "CaskaydiaCove Nerd Font"
  config.macos_window_background_blur = 30
  config.window_background_opacity = 0.80
end

return module


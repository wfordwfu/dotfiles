local wezterm = require("wezterm")

local config = wezterm.config_builder()

local appearance = require("appearance")
appearance.apply_to_config(config)

return config

local wezterm = require("wezterm")

local config = wezterm.config_builder()

local appearance = require("appearance")
appearance.apply_to_config(config)

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
return config

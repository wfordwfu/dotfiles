local wezterm = require("wezterm")
local config = wezterm.config_builder()
local utils = require("utils")


local performance = require("performance")
local appearance = require("appearance")
local font = require("font")

utils.apply_config(config, performance)
utils.apply_config(config, appearance)
utils.apply_config(config, font)

return config

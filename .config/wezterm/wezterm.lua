local wezterm = require("wezterm")
local config = wezterm.config_builder()

function apply_config(config, module)
    for k, v in pairs(module) do
        config[k] = v
    end
    return config
end

local performance = require("performance")
local appearance = require("appearance")
local font = require("font")

apply_config(config, performance)
apply_config(config, appearance)
apply_config(config, font)

return config

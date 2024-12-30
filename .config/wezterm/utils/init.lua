local utils = {}

function utils.apply_config(config, module)
    for k, v in pairs(module) do
        config[k] = v
    end
    return config
end

return utils
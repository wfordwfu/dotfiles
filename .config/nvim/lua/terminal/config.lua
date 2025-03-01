-- Terminal plugin configuration options
local M = {}

-- Default configuration
M.options = {
  -- Terminal window settings
  width_percentage = 90,  -- Width as percentage of screen
  height_percentage = 90, -- Height as percentage of screen
  border = 'rounded',
  
  -- Terminal behavior
  insert_on_open = true,  -- Auto-enter insert mode when terminal opens
  close_on_exit = false,  -- Keep terminal buffer when process exits
  
  -- Skip patterns (like shebang lines)
  skip_patterns = {
    shebang = true,       -- Skip lines starting with #!
    shebang_pattern = "^%s*#!"
  },
  
  -- Keymaps
  keys = {
    toggle = '<Leader>tt',
    send_line = '<Leader>tl',
    send_selection = '<Leader>tv',
    send_to_cursor = '<Leader>tp',
    send_buffer = '<Leader>tb'
  }
}

-- Function to update the configuration
function M.setup(user_config)
  user_config = user_config or {}
  
  -- Merge user config with defaults
  for k, v in pairs(user_config) do
    if type(v) == "table" and type(M.options[k]) == "table" then
      -- Deep merge for nested tables
      for k2, v2 in pairs(v) do
        M.options[k][k2] = v2
      end
    else
      M.options[k] = v
    end
  end
  
  return M.options
end

return M
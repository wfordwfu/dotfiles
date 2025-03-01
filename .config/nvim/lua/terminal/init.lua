-- Terminal plugin entry point
local config = require('terminal.config')
local core = require('terminal.core')
local commands = require('terminal.commands')
local keymaps = require('terminal.keymaps')

local M = {}

-- Main setup function
function M.setup(user_config)
  -- Apply user configuration
  config.setup(user_config)
  
  -- Setup commands
  if commands.setup_commands then
    commands.setup_commands()
  end
  
  -- Setup keymaps
  if keymaps.setup then
    keymaps.setup()
  end
  
  -- Make functions globally available
  _G.terminal_toggle = core.toggle
  _G.terminal_send = core.send_command
  _G.terminal_send_line = commands.send_current_line
  _G.terminal_send_selection = commands.send_visual_selection
  _G.terminal_send_buffer = commands.send_buffer
  _G.terminal_send_to_cursor = commands.send_to_cursor
end

-- Export the public API
M.toggle = core.toggle
M.send = core.send_command
M.send_line = commands.send_current_line
M.send_selection = commands.send_visual_selection
M.send_buffer = commands.send_buffer
M.send_to_cursor = commands.send_to_cursor
M.state = core.state

return M
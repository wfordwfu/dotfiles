local config = require('terminal.config')
local core = require('terminal.core')
local commands = require('terminal.commands')

local M = {}

-- Setup keymappings
function M.setup()
  local opts = { noremap = true, silent = true }
  local keys = config.options.keys
  
  -- Toggle terminal
  vim.api.nvim_set_keymap('n', keys.toggle, '<cmd>lua require("terminal.core").toggle()<CR>', opts)
  vim.api.nvim_set_keymap('t', keys.toggle, '<C-\\><C-n><cmd>lua require("terminal.core").toggle()<CR>', opts)
  
  -- Send current line to terminal
  vim.api.nvim_set_keymap('n', keys.send_line, '<cmd>lua require("terminal.commands").send_current_line()<CR>', opts)
  
  -- Send visual selection to terminal
  vim.api.nvim_set_keymap('v', keys.send_selection, ':<C-u>lua require("terminal.commands").send_visual_selection()<CR>', opts)
  
  -- Send entire buffer to terminal
  vim.api.nvim_set_keymap('n', keys.send_buffer, '<cmd>lua require("terminal.commands").send_buffer()<CR>', opts)
  
  -- Send from start of buffer to cursor
  vim.api.nvim_set_keymap('n', keys.send_to_cursor, '<cmd>lua require("terminal.commands").send_to_cursor()<CR>', opts)
end

return M
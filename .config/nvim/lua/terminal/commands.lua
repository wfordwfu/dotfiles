-- Terminal command handlers
local core = require('terminal.core')

local M = {}

-- Terminal command handlers
local core = require('terminal.core')

local M = {}

-- Send the current line to the terminal
function M.send_current_line()
  local line = vim.api.nvim_get_current_line()
  if not core.should_skip_line(line) then
    core.send_command(line)
  else
    print("Skipped line (matched skip pattern)")
  end
end

-- Send visually selected text to the terminal
function M.send_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_row, end_row = start_pos[2], end_pos[2]
  
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  if #lines > 0 then
    -- Filter out lines that should be skipped
    local filtered_lines = {}
    for _, line in ipairs(lines) do
      if not core.should_skip_line(line) then
        table.insert(filtered_lines, line)
      end
    end
    
    if #filtered_lines > 0 then
      local text = table.concat(filtered_lines, "\n")
      core.send_command(text)
    else
      print("No lines to send (all matched skip patterns)")
    end
  end
end

-- Send entire buffer to the terminal
function M.send_buffer()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if #lines > 0 then
    -- Filter out lines that should be skipped
    local filtered_lines = {}
    for _, line in ipairs(lines) do
      if not core.should_skip_line(line) then
        table.insert(filtered_lines, line)
      end
    end
    
    if #filtered_lines > 0 then
      local text = table.concat(filtered_lines, "\n")
      core.send_command(text)
    else
      print("No lines to send (all matched skip patterns)")
    end
  end
end

-- Send from start of buffer to current cursor line
function M.send_to_cursor()
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, cursor_row, false)
  
  if #lines > 0 then
    -- Filter out lines that should be skipped
    local filtered_lines = {}
    for _, line in ipairs(lines) do
      if not core.should_skip_line(line) then
        table.insert(filtered_lines, line)
      end
    end
    
    if #filtered_lines > 0 then
      local text = table.concat(filtered_lines, "\n")
      core.send_command(text)
    else
      print("No lines to send (all matched skip patterns)")
    end
  end
end

-- Setup Vim commands
function M.setup_commands()
  -- Create the TermRun command
  vim.cmd([[command! -nargs=1 TermRun lua require('terminal.core').send_command(<f-args>)]])
  
  -- Create the TermToggle command
  vim.cmd([[command! TermToggle lua require('terminal.core').toggle()]])
  
  -- Create the TermSendLine command
  vim.cmd([[command! TermSendLine lua require('terminal.commands').send_current_line()]])
  
  -- Create the TermSendSelection command
  vim.cmd([[command! -range TermSendSelection lua require('terminal.commands').send_visual_selection()]])
  
  -- Create the TermSendBuffer command
  vim.cmd([[command! TermSendBuffer lua require('terminal.commands').send_buffer()]])
  
  -- Create the TermSendToCursor command
  vim.cmd([[command! TermSendToCursor lua require('terminal.commands').send_to_cursor()]])
end

return M

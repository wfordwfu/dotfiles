local config = require('terminal.config')

local M = {}

-- Terminal state object
M.state = {
  buf = nil,
  win = nil,
  job_id = nil,
  is_open = false,
  terminal_pending = false
}

-- Create a new terminal buffer if needed
function M.setup_terminal()
  if M.state.buf == nil or not vim.api.nvim_buf_is_valid(M.state.buf) then
    -- Create a new terminal buffer
    M.state.buf = vim.api.nvim_create_buf(false, true)
    
    -- Set buffer options first
    vim.api.nvim_buf_set_option(M.state.buf, 'buflisted', false)
    vim.api.nvim_buf_set_option(M.state.buf, 'filetype', 'terminal')
    
    -- Open terminal in the buffer (defer until window is created)
    M.state.terminal_pending = true
  end
end

-- Toggle terminal window visibility
function M.toggle()
  -- Create terminal if it doesn't exist
  M.setup_terminal()
  
  if M.state.is_open then
    -- Close terminal window
    if M.state.win and vim.api.nvim_win_is_valid(M.state.win) then
      vim.api.nvim_win_close(M.state.win, true)
    end
    M.state.win = nil
    M.state.is_open = false
  else
    -- Get editor dimensions
    local editor_width = vim.o.columns
    local editor_height = vim.o.lines
    
    -- Calculate window size based on percentages
    local width = math.floor(editor_width * config.options.width_percentage / 100)
    local height = math.floor(editor_height * config.options.height_percentage / 100)
    
    -- Calculate position to center the window
    local row = math.floor((editor_height - height) / 2)
    local col = math.floor((editor_width - width) / 2)
    
    -- Position the terminal as a centered floating window
    local opts = {
      relative = 'editor',
      width = width,
      height = height,
      row = row,
      col = col,
      style = 'minimal',
      border = config.options.border
    }
    
    -- Create window
    M.state.win = vim.api.nvim_open_win(M.state.buf, true, opts)
    M.state.is_open = true
    
    -- Set window options
    vim.api.nvim_win_set_option(M.state.win, 'winhl', 'Normal:Normal')
    vim.api.nvim_win_set_option(M.state.win, 'winblend', 0)
    
    -- Initialize terminal if needed
    if M.state.terminal_pending then
      vim.fn.termopen(vim.o.shell, {
        on_exit = function()
          if not config.options.close_on_exit then
            M.state.buf = nil
            M.state.job_id = nil
          end
        end
      })
      
      -- Get the job ID for sending commands later
      M.state.job_id = vim.b[M.state.buf].terminal_job_id
      M.state.terminal_pending = false
    end
    
    -- Start in insert mode if configured
    if config.options.insert_on_open then
      vim.cmd('startinsert')
    end
  end
end

-- Send a command to the terminal
function M.send_command(command)
  -- If terminal doesn't exist yet, create it
  if M.state.buf == nil or not vim.api.nvim_buf_is_valid(M.state.buf) then
    print("Terminal not initialized, creating it now...")
    M.toggle()
    
    -- Slight delay to ensure terminal is ready
    vim.defer_fn(function()
      if M.state.job_id then
        vim.fn.chansend(M.state.job_id, command .. "\n")
      end
    end, 100)
    return
  end

  -- Terminal exists but is not open, open it
  if M.state.job_id and not M.state.is_open then
    M.toggle()
    vim.fn.chansend(M.state.job_id, command .. "\n")
  -- Terminal exists and is open
  elseif M.state.job_id then
    vim.fn.chansend(M.state.job_id, command .. "\n")
  else
    print("Terminal not properly initialized")
  end
end

-- Check if a line should be skipped
function M.should_skip_line(line)
  local opts = config.options.skip_patterns
  if opts.shebang and line:match(opts.shebang_pattern) then
    return true
  end
  return false
end

return M
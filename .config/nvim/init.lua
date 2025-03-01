require "keymap"
require "options"

local obsidian_path = os.getenv("OBSIDIAN_PATH")

if obsidian_path then
    local utils = require("obsidian-utils")

    vim.api.nvim_create_user_command("SaveToFabric", function(opts)
      utils.save_to_obsidian(opts.args, "notes/fabric")
    end, {
        nargs = 1,
        desc = "Saves current buffer to notes/fabric in obsidian",
    })

    vim.api.nvim_create_user_command("FabricYT", function(opts)
      utils.process_fabricyt(opts)
    end, {
        nargs = '*',
        desc = "Process URL from clipboard through fabric cli with space separated patterns",
    })
end

-- In your init.lua file
require('terminal').setup({
  -- Optional: Override default configuration
  width_percentage = 90,      -- Width as percentage of screen
  height_percentage = 90,     -- Height as percentage of screen
  border = 'rounded',         -- Window border style
  insert_on_open = true,      -- Enter insert mode when opening terminal
  
  -- Skip patterns (when sending code to terminal)
  skip_patterns = {
    shebang = true,           -- Skip lines starting with #!
    shebang_pattern = "^%s*#!"
  },
  
  -- Custom keymaps
  keys = {
    toggle = '<Leader>tt',    -- Toggle terminal window
    send_line = '<Leader>tl', -- Send current line
    send_selection = '<Leader>tv', -- Send visual selection
    send_to_cursor = '<Leader>tp', -- Send buffer up to cursor
    send_buffer = '<Leader>tb' -- Send entire buffer
  }
})


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")


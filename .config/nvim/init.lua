require "keymap"
require "options"

local utils = require("utils")

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


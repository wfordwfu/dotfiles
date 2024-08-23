local options = {
  -- nu = true,
  relativenumber = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  ignorecase = true,
  scrolloff = 8,
  -- smartindent = true,
  -- wrap = true,
  -- swapfile = false,
  -- backup = false,
  -- hlsearch = false,
  -- incsearch = true,
  -- termguicolors = true,
  -- signcolumn = "yes",
  -- updatetime = 50,
  -- colorcolumn = "80",
  -- fileencoding = "utf-8",
  -- guifont = "monospace:h17"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

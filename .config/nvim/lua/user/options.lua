local options = {
  nu = true,
  relativenumber = true,
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  smartindent = true,
  wrap = true,
  swapfile = false,
  backup = false,
  hlsearch = false,
  incsearch = true,
  termguicolors = true,
  scrolloff = 8,
  signcolumn = "yes",
  updatetime = 50,
  colorcolumn = "80",
  fileencoding = "utf-8",
  guifont = "monospace:h17"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

--vim.opt.guicursor = ""
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
--vim.opt.undofile = true
vim.opt.isfname:append("@-@")



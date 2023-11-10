-- return function(use)
--   use({
--     "ellisonleao/gruvbox.nvim",
--   })
-- -- install without yarn or npm
--   use({
--     "iamcco/markdown-preview.nvim",
--     run = function() vim.fn["mkdp#util#install"]() end,
--   })
--   --use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
-- end

return {
  {
    "ellisonleao/gruvbox.nvim",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

}

return {
  {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", "yamlls", "gopls", "jqls", "pyright", "marksman"
            }
        })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config('lua_ls', {})
      vim.lsp.config('yamlls', {})
      vim.lsp.config('gopls', {})
      vim.lsp.config('jqls', {})
      vim.lsp.config('pyright', {})
      vim.lsp.config('marksman', {})
    
      vim.lsp.enable({ 'lua_ls', 'yamlls', 'gopls', 'jqls', 'pyright', 'marksman' })
    
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
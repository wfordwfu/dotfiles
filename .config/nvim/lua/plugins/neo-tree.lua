return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    opts = {
      filesystem = {
          filtered_items = {
              visible = true,
              show_hidden_count = true,
              hide_dotfiles = false,
              hide_gitignored = false,
              hide_by_name = {
                  -- '.git',
              },
              never_show = {},
          },
          follow_current_file = {
              enabled = true,  -- auto-focus file when you open it
          },
          group_empty_dirs = true,  -- compact empty directories into a single item
          use_libuv_file_watcher = true,  -- auto-refresh on file changes
      }
    },
    config = function()
      vim.keymap.set('n', '<C-n>', '<cmd>Neotree toggle<CR>', { desc = "Open Neotree" })
    end,
}
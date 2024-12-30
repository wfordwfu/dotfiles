return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled =  true,
          theme = "nord",
          component_separators = "|",
          section_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              function()
                return vim.api.nvim_win_get_number(0)
              end,
            }
          },
          lualine_b = { "branch", "diagnostics" },
          lualine_c = { "mode" },
        },
        inactive_sections = {},
        winbar = {
          lualine_a = {
            {
              function()
                return vim.api.nvim_win_get_number(0)
              end,
            }
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              newfile_status = false,
              path = 3,
            }
          }
        },
        inactive_winbar = {
          lualine_a = {
            {
              function()
                return vim.api.nvim_win_get_number(0)
              end,
            }
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              newfile_status = false,
              path = 1,
            }
          }
        }
      })
    end
}
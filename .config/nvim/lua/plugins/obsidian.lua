local obsidian_path = os.getenv("OBSIDIAN_PATH")

if not obsidian_path then
  return {}
end

return {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  --  lazy = true,
  opts = {
    workspaces = {
      {
        name = "personal",
        path = obsidian_path,
      },
    },
    daily_notes = {
      folder = "inbox",
      template = "system/templates/daily"
    }
  },
}

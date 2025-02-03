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
        path = os.getenv("OBSIDIAN_PATH"),
      },
    },
    daily_notes = {
      folder = "inbox",
      template = "system/templates/daily"
    }
  },
}

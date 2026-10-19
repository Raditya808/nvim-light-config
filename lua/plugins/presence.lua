return {
  "vyfor/cord.nvim",
  build = "./build",
  event = "VeryLazy",
  opts = {
    user_id = nil,
    log_level = "error",
    editor = {
      client = "neovim",
      tooltip = "The One True Editor",
    },
    display = {
      show_time = true,
      show_repository = true,
      show_cursor_position = true,
    },
  
  },
}

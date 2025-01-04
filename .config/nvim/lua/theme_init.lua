local M = {
  {
    "luisiacc/gruvbox-baby",
    config = function()
      local c = require("gruvbox-baby.colors").config()
      vim.g.gruvbox_baby_background_color = "dark"
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_transparent_mode = 1
      vim.g.gruvbox_baby_telescope_theme = 1
      vim.g.gruvbox_baby_highlights = {
        MatchParen = {fg=c.milk, style="bold"},
        ColorColumn = {bg=c.dark},
        StatusLine = {bg="none"},
        WinBar = {bg=c.none},
        IncSearch = {link="Search"},
      }
      vim.g.gruvbox_baby_color_overrides = {
        clean_green = "#d3869b",
      }
      vim.cmd.colorscheme "gruvbox-baby"
    end
  },
}

return M

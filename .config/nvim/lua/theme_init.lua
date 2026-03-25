_G.apply_theme = function(variant)
  variant = variant or "muted"

  vim.g.gruvbox_baby_background_color = "dark"
  vim.g.gruvbox_baby_function_style = "NONE"
  vim.g.gruvbox_baby_transparent_mode = 1
  vim.g.gruvbox_baby_telescope_theme = 1

  local c = require("gruvbox-baby.colors").config()

  vim.g.gruvbox_baby_highlights = {
    MatchParen  = { fg = c.milk, style = "bold" },
    ColorColumn = { bg = c.dark },
    StatusLine  = { bg = "none" },
    WinBar      = { bg = c.none },
    IncSearch   = { link = "Search" },
  }

  if variant == "muted" then
    vim.g.gruvbox_baby_color_overrides = {
      dark0            = "#0D0E0F",
      dark             = "#181818",
      foreground       = "#B7AC9A",
      background_light = "#32302F",
      medium_gray      = "#504945",
      comment          = "#656565",
      gray             = "#7A7A7A",
      soft_yellow      = "#9E8A73",
      soft_green       = "#7D877D",
      bright_yellow    = "#AE9A83",
      orange           = "#8B6D5F",
      red              = "#C75E5C",
      error_red        = "#C94E4B",
      magenta          = "#8C7A85",
      pink             = "#9A828C",
      light_blue       = "#6E7477",
      dark_gray        = "#666666",
      blue_gray        = "#757575",
      forest_green     = "#708070",
      clean_green      = "#B39AA3",
      milk             = "#B7AC9A",
      none             = "NONE",
    }
  else
    vim.g.gruvbox_baby_color_overrides = {
      clean_green = "#d3869b",
    }
  end

  vim.cmd.colorscheme("gruvbox-baby")
end

return {
  {
    "luisiacc/gruvbox-baby",
    config = function()
      apply_theme("muted")
    end,
  },
}


local M = {
  { 
    "luisiacc/gruvbox-baby",
    config = function()
      local c = require("gruvbox-baby.colors").config()
      vim.g.gruvbox_baby_background_color = "dark"
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_transparent_mode = 1
      vim.g.gruvbox_baby_highlights = {
        MatchParen = {fg=c.milk, style="bold"},
        ColorColumn = {bg=c.medium_gray},
      }
      vim.cmd.colorscheme "gruvbox-baby"
      vim.api.nvim_set_hl(0, 'StatusLine', {bg='none'})
      vim.cmd('hi BufferTabpageFill guibg=NONE')
    end
  },
  {
    "kepano/flexoki-neovim",
    config = function()
      -- vim.cmd.colorscheme "flexoki-dark"
      -- vim.api.nvim_set_hl(0, 'StatusLine', {bg='none'})
      -- vim.cmd('hi BufferTabpageFill guibg=NONE')
    end
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        transparent = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        },
        overrides = function(colors)
          return { 
            StatusLine = {bg = "none"},
            BufferTabpageFill = {bg = "none"},
          }
        end,
      })
      -- vim.cmd.colorscheme "kanagawa-wave"
    end
  },
  {
    "lmburns/kimbox",
    config = function()
      require("kimbox").setup({
        transparent = true
      })
      -- vim.cmd.colorscheme "kimbox"
      -- vim.api.nvim_set_hl(0, 'StatusLine', {bg='none'})
      -- vim.cmd('hi BufferTabpageFill guibg=NONE')
    end,
  },
  {
    "blazkowolf/gruber-darker.nvim",
    config = function()
      -- vim.cmd.colorscheme("gruber-darker")
    end,
  },
}

return M

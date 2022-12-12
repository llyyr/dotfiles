vim.g.gruvbox_baby_function_style = "NONE"
vim.g.gruvbox_baby_transparent_mode = 1
vim.g.gruvbox_baby_highlights = {MatchParen = {fg="#cc241d", style="bold"}}
vim.cmd[[colorscheme gruvbox-baby]]

local custom_gruvbox_baby = require'lualine.themes.gruvbox-baby'
custom_gruvbox_baby.inactive.a.bg = '#000000'
custom_gruvbox_baby.inactive.b.bg = '#000000'
custom_gruvbox_baby.inactive.c.bg = '#000000'
require('lualine').setup {
    options = {
        theme = custom_gruvbox_baby,
    }
}
vim.api.nvim_set_hl(0, 'BufferTabpageFill', {bg='#000000'}) 

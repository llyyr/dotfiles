local c = require("gruvbox-baby.colors").config()
vim.g.gruvbox_baby_background_color = "dark"
vim.g.gruvbox_baby_function_style = "NONE"
vim.g.gruvbox_baby_transparent_mode = 1
vim.g.gruvbox_baby_highlights = {
    MatchParen = {fg=c.milk, style="bold"},
    ColorColumn = {bg=c.medium_gray},
}
vim.cmd[[colorscheme gruvbox-baby]]

--[[ vim.g.acme_style = "colorful" ]]
--vim.cmd[[colorscheme acme]]

local custom_gruvbox = require'lualine.themes.gruvbox-baby'
custom_gruvbox.inactive.a.bg = '#000000'
custom_gruvbox.inactive.b.bg = '#000000'
custom_gruvbox.inactive.c.bg = '#000000'
require('lualine').setup {
    options = {
        --[[ theme = 'auto', ]]
        theme = custom_gruvbox,
    }
}
vim.api.nvim_set_hl(0, 'BufferTabpageFill', {bg='#000000'}) 

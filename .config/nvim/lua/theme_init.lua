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

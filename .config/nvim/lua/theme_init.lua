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

local custom_gruvbox = require'lualine.themes.gruvbox-baby'
custom_gruvbox.inactive.a.bg = 'none'
custom_gruvbox.inactive.b.bg = 'none'
custom_gruvbox.inactive.c.bg = 'none'
require('lualine').setup {
    options = {
        theme = 'auto',
        --[[ theme = custom_gruvbox, ]]
    }
}

vim.g.acme_style = "colorful"
--[[ vim.cmd.colorscheme "acme" ]]

require("catppuccin").setup({
    transparent_background = true,
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
        },
        lsp_trouble = false,
        lsp_saga = false,
        coc_nvim = false,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = false,
            show_root = false,
        },
        which_key = false,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        dashboard = false,
        neogit = false,
        leap = true,
        vim_sneak = false,
        fern = false,
        barbar = true,
        bufferline = false,
        markdown = true,
        lightspeed = false,
        ts_rainbow = true,
        hop = false,
        cmp = true,
        notify = false,
        telekasten = false,
    },
})

-- setup must be called before loading
--[[ vim.cmd.colorscheme "catppuccin" ]]


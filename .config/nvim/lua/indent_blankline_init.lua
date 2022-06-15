--[[ Striped indentation ]]--
if false then
    local colors = require'catppuccin.api.colors'.get_colors()

    colors_list = {
        ["IndentBlanklineIndent1"] = { gui = "nocombine", bg = colors.black2 },
        ["IndentBlanklineIndent2"] = { gui = "nocombine", bg = colors.black0 },
    }

    for name, style in pairs(colors_list) do
        vim.api.nvim_command(
             [[highlight ]]
             .. name .. ' ' ..
             'guibg=' .. style.bg .. ' ' ..
             'gui=' ..   style.gui
        )
    end
end

require('indent_blankline').setup({
    --[[
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    ]]--

    show_trailing_blankline_indent = true,
    show_first_indent_level = false,

    max_indent_increase = 1,

    use_treesitter = true,
    show_current_context = false,
    show_current_context_start = false,
    show_current_context_start_on_current_line = false,

    show_end_of_line = false,

    show_foldtext = false,
    strict_tabs   = false,

    filetype_exclude = { 'help' },
    buftype_exclude  = { 'terminal' },
})

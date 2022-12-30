require('indent_blankline').setup({
    char = "|",
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

require("ibl").setup {
    indent = { char = "|" },
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}
local hooks = require "ibl.hooks"
hooks.register( hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
hooks.register( hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)


local M = { 
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
}

M.config = function()
  local hooks = require "ibl.hooks"
  hooks.register( hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
  hooks.register( hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  require("ibl").setup{
    indent = { char = "|" },
    whitespace = {
      remove_blankline_trail = false,
    },
    scope = { enabled = true },
  }
end

return M

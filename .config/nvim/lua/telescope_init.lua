local M = {
  'nvim-telescope/telescope.nvim', 
  dependencies = 
  { 'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make' },
  { 'AckslD/nvim-neoclip.lua', 
    opts = {
      history = 256,
      enable_persistent_history = false,
      preview = true,
      content_spec_column = true,
      default_register = '+',
      on_paste = {
        set_reg = true,
      },
    }
  },
  opts = {
    defaults = {
      dynamic_preview_title = true,
    },
    pickers = {
      find_files = {
      },
    },
  }
}

M.config = function()
  local telescope = require('telescope')
  telescope.load_extension('fzf')
  telescope.load_extension('neoclip')
end

return M

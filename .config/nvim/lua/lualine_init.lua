local M = { "nvim-lualine/lualine.nvim" }

M.opts = {
  options = {
    icons_enabled = false,
    theme = 'auto',
    section_separators = '',
    component_separators = { left = '|', right = '|'},
    disabled_filetypes = { },
    padding = 1,
  },
  filetype_names = {
    TelescopePrompt = 'Telescope',
    dashboard = 'Dashboard',
    packer = 'Packer',
    fzf = 'FZF',
    alpha = 'Alpha'
  }, -- shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
  sections = {
    lualine_a = { 'mode'     },
    lualine_b = { 'branch'   },
    lualine_c = { 'filename' },
    lualine_x = { 'diagnostics', 'diff' },
    lualine_y = { 'encoding', 'fileformat', 'filetype', 'filesize' },
    lualine_z = { 'location', "progress" }
  },
  inactive_sections = {
    lualine_a = { },
    lualine_b = { },
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = { 'filetype' },
    lualine_z = { }
  },
  tabline = {},
  extensions = { 'fzf' }
}

return M

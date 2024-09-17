return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local lualine = require('lualine')

    -- Color table for highlights
    local colors = {
      bg       = 'none',
      fg       = '#bbc2cf',
      yellow   = '#ECBE7B',
      cyan     = '#008080',
      darkblue = '#081633',
      green    = '#98be65',
      orange   = '#FF8800',
      violet   = '#a9a1e1',
      magenta  = '#c678dd',
      blue     = '#51afef',
      red      = '#ec5f67',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      'mode',
      cond = conditions.buffer_not_empty,
      color = { gui = 'bold' },
    }

    ins_left {
      'branch',
      color = { fg = colors.violet, gui = 'bold' },
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = 'bold' },
      path = 3
    }

    ins_right {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = 'E:', warn = 'W:', info = 'I:' },
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
      },
    }

    ins_right {
      'diff',
      symbols = {added = '+', modified = '~', removed = '-'},
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    ins_right {
      'encoding',
      fmt = string.upper,
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = 'bold' },
      show_bomb = true,
    }

    ins_right {
      'fileformat',
      fmt = string.upper,
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
      'filetype',
      cond = conditions.buffer_not_empty,
    }

    ins_right {
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    ins_right { 'location' }

    ins_right {
      'progress',
      color = { fg = colors.fg, gui = 'bold' }
    }

    -- Initialize lualine
    lualine.setup(config)
  end,
}

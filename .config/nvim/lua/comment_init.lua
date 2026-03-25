local M = {
  'numToStr/Comment.nvim',
  event = 'BufReadPost',
}

function M.config()
  require('Comment').setup({})

  local ft = require('Comment.ft')
  ft.set('nasm', '; %s')
  ft.set('asm', { '// %s', '/* %s */' })
end

return M


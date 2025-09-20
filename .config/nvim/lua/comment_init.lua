local M = {
  'numToStr/Comment.nvim',
  event = 'BufReadPost',
}

function M.config()
  require('Comment').setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  })

  local ft = require('Comment.ft')
  ft.set('nasm', '; %s')
  ft.set('asm', { '// %s', '/* %s */' })
end

return M


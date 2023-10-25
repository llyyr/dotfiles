local M = {
  'numToStr/Comment.nvim',
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  opts = {
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  },
}

M.config = function()
  local ft = require('Comment.ft')
  ft.set('nasm', '; %s')
  ft.set('asm', { '// %s', '/* %s */' })
end

return M

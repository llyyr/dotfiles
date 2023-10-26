local M = {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
}
M.config = function()
  require('nvim-autopairs').setup({
    check_ts = true,
    disable_in_macro = true,
    disable_in_visualblock = true,
    enable_moveright = true,
    enable_afterquote = true,
    enable_check_bracket_line = true,
    disable_filetype = { 'TelescopePrompt' },
    ts_config = {

    },
    map_bs = true,
    map_c_h = false,
    map_c_w = false,
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


  local Rule = require('nvim-autopairs.rule')
end

return M

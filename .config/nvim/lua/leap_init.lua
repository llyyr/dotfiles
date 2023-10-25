local M = {
  "ggandor/leap.nvim",
  opts = {
    case_insensitive = true,
  }
}

M.config = function()
  require"leap".add_default_mappings()
end

return M

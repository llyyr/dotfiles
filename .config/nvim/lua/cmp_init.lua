local M = {
  'hrsh7th/nvim-cmp', 
  dependencies = { 
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'onsails/lspkind-nvim',
    'ray-x/cmp-treesitter',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
  }
}

M.config = function()
  local cmp = require('cmp')
  local luasnip = require("luasnip")
  local lspkind = require('lspkind')

  require("luasnip.loaders.from_snipmate").lazy_load()

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    enabled = function()
      local ctx = require"cmp.config.context"
      if ctx.in_treesitter_capture("comment") == true or
        ctx.in_treesitter_capture("string") == true or
        ctx.in_syntax_group("Comment") == true or
        ctx.in_syntax_group("String") == true then
        return false
      else
        return true
      end
    end,
  })
  --[[ LSP initialization ]]--
  local lsp = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lsp.clangd.setup({
    capabilities = capabilities,
    cmd = { "clangd",
      "--malloc-trim",
      "-j=4",
      "--background-index",
      "--pch-storage=memory",
      "--header-insertion=never",
      "--log=verbose",
      "--all-scopes-completion",
      "--clang-tidy",
      "--completion-style=detailed",
      "--enable-config",
    },
    filetypes = { "c", "h", "cc", "cpp", "hpp", "objc", "objcpp" },
  })

  lsp.pyright.setup{}
end

return M

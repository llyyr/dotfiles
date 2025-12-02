local M = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'onsails/lspkind-nvim',
    'ray-x/cmp-treesitter',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
  }
}

M.config = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

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

    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    completion = {
      keyword_length = 3,
      autocomplete = false,
    },
    experimental = {
      ghost_text = { hl_group = 'Comment' },
    },
    view = {
      entries = {
        name = 'custom', -- or native
        selection_order = 'top_down'
      },
    },
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        menu = ({
          buffer        = "[Buffer]",
          nvim_lsp      = "[LSP]",
          nvim_lua      = "[Lua]",
          latex_symbols = "[Latex]",
          treesitter    = "[TS]",
        })
      })
    },
    mapping = cmp.mapping.preset.insert({
      -- Close
      ['<Esc>'] = cmp.mapping.abort(),
      ['<S-Esc>'] = cmp.mapping.close(),

      -- Docs
      ['<S-Down>'] = cmp.mapping.scroll_docs(1),

      -- Select
      ['<Down>'] = cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Select,
      }),
      ['<Up>'] = cmp.mapping.select_prev_item({
        behavior = cmp.SelectBehavior.Select,
      }),

      -- Complete
      ['<Tab>'] = cmp.mapping(
        function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end,
        { "i", "c" }
      ),

      ["<S-Tab>"] = cmp.mapping(
        function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
        { "i", "c" }
      ),

      ['<CR>'] = cmp.mapping(
        function(fallback)
          if cmp.visible() and cmp.get_selected_entry() ~= nil then
            cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
          else
            fallback()
          end
        end,
        { "i", "s" }
      ),
    }),
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp' },
      },
      {
        { name = 'treesitter' },
      },
      {
        { name = 'buffer' },
      }
    )
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = 'path' },
      },
      {
        { name = 'cmdline' },
      }
    )
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  vim.lsp.config(
    'clangd', {
      cmd = { "clangd", "--background-index" },
      filetypes = { "c", "cpp", "h", "hpp" },
    },
    'basedpyright', {
      settings = { basedpyright = { typeCheckingMode = "standard" } }
    }
  )

  vim.lsp.enable('clangd', {
    on_attach = function(client, bufnr)
      local opts_l = { silent = true, noremap = true }
      local maps = vim.keymap.set
      maps('n', 'K', vim.lsp.buf.hover, opts_l)
      maps('n', 'gi', vim.lsp.buf.incoming_calls, opts_l)
      maps('n', 'go', vim.lsp.buf.outgoing_calls, opts_l)
    end,
    capabilities = capabilities,
  })

  vim.lsp.enable('basedpyright', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      local opts_l = { silent = true, noremap = true }
      local maps = vim.keymap.set
      maps('n', 'K', vim.lsp.buf.hover, opts_l)
      maps('n', 'gi', vim.lsp.buf.incoming_calls, opts_l)
      maps('n', 'go', vim.lsp.buf.outgoing_calls, opts_l)
    end,
  })
end

return M

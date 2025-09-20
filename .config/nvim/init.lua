vim.opt.shell           = '/bin/sh'
vim.opt.undofile        = true
vim.opt.undodir         = '/home/llyyr/.cache/undo'
vim.opt.mouse           = 'a'
vim.opt.expandtab       = true                   -- tabs instead of spaces
vim.opt.shiftwidth      = 4                      -- shift 4 spaces when tab
vim.opt.tabstop         = 4                      -- 1 tab == 4 spaces
vim.opt.softtabstop     = 4                      -- same
vim.opt.smartindent     = true                   -- autoindent new lines
vim.opt.wrap            = true
vim.opt.linebreak       = true
vim.opt.splitbelow      = true
vim.opt_splitright      = true
vim.opt.smd             = true
vim.opt.number          = true
vim.opt.termguicolors   = true
vim.opt.ignorecase      = true
vim.opt.relativenumber  = true
vim.opt.smartcase       = true
vim.opt.magic           = true
vim.opt.showmatch       = true                  -- highlight matching parenthesis
vim.opt.textwidth       = 0
vim.opt.colorcolumn     = '81'
vim.opt.foldenable      = false
vim.opt.foldmethod      = "expr"
vim.opt.completeopt     = { "menu", "menuone", "noselect" }
vim.opt.clipboard       = 'unnamedplus'          -- copy/paste to system clipboard
vim.opt.signcolumn      = 'yes'                   -- disable signscolumn
vim.opt.list            = true
vim.opt.listchars       = 'tab:╶─╴,lead:·,trail:▒,extends:►,precedes:◄,nbsp:␣'
vim.g.mapleader         = ','
vim.g.netrw_fastbrowse  = 0
vim.g.python3_host_prog = 'python3'
vim.opt.sessionoptions  = { "blank", "buffers", "curdir", "folds", "help",
                            "tabpages", "winsize", "winpos", "terminal" }
vim.opt.incsearch       = true
vim.opt.updatetime      = 500
vim.filetype.add({
  extension = {
    h = "c",
    asm = "nasm",
    S = "asm",
  },
})
vim.g.skip_ts_context_commentstring_module = true
vim.g.zig_fmt_autosave = false
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.loader.enable()
require("lazy").setup({
  { 'nvim-lua/plenary.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { import = 'treesitter_init' },
  { import = 'cmp_init' },
  { import = 'telescope_init' },
  { import = 'theme_init' },
  { import = 'lualine_init' } ,
  { import = 'barbar_init' },
  { import = 'todo-comments_init' },
  { import = 'leap_init' },
  { import = 'scrollview_init' },
  { import = 'indent_blankline_init' },
  { import = 'guess-indent_init' },
  { import = 'autopairs_init' },
  { import = 'copilot_init' },
  { import = 'dropbar_init' },
  { import = 'comment_init' },
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    vim.fn.matchadd("GitConflict", [[^<<<<<<< .*\|^=======$\|^>>>>>>> .*$]])
  end,
  desc = "Highlight Git conflict markers",
})

vim.keymap.set("n", "]x", function()
  vim.fn.search([[^<<<<<<< .*\|^=======$\|^>>>>>>> .*$]], "W")
end, { desc = "Next conflict marker" })

vim.keymap.set("n", "[x", function()
  vim.fn.search([[^<<<<<<< .*\|^=======$\|^>>>>>>> .*$]], "bW")
end, { desc = "Previous conflict marker" })

vim.api.nvim_set_hl(0, "GitConflict", { fg = "#fb4934", bold = true })

-- Restore cursor position when opening a file
-- https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match("commit") and ft:match("rebase"))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys('g`"', "nx", false)
        end
      end,
    })
  end,
})

vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<A-j>', ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>.', '/<c-r>=expand("<cword>")<CR><CR>N', { noremap = true, silent = true })

--[[ Esc to clear search ]]--
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<cr>', { noremap = true, silent = true })

--[[ Builtin ]]--
vim.api.nvim_set_keymap('n', '<leader>ff', ':lua require(\'telescope.builtin\').find_files()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':lua require(\'telescope.builtin\').live_grep()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':lua require(\'telescope.builtin\').buffers()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fl', ':lua require(\'telescope.builtin\').diagnostics()<cr>', { noremap = true, silent = true })

--[[ LSP ]]--
vim.api.nvim_set_keymap('n', '<leader>fd', ':lua require(\'telescope.builtin\').lsp_definitions()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', ':lua require(\'telescope.builtin\').lsp_references()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', ':lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<cr>', { noremap = true, silent = true })

--[[ Clipboard ]]--
vim.api.nvim_set_keymap('n', '<leader>cc', ':lua require(\'telescope\').extensions.neoclip.default()<cr>', { noremap = true, silent = true })

--[[ Custom commands ]]--
vim.api.nvim_set_keymap('n', '<leader>ww', ':w !sudo tee % > /dev/null<cr>', { noremap = true, silent = true })

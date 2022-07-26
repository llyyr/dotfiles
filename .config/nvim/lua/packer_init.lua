vim.cmd [[packadd packer.nvim]]

packer = require('packer')

packer.init({
    git = {
        clone_timeout = 300,
    },
    luarocks = {
        python_cmd = 'python3.10'
    },
    profile = {
        enable = false,
    },
})

return packer.startup(function()
    use { 'wbthomason/packer.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lua/plenary.nvim' }
    
    use { 'rebelot/kanagawa.nvim', as = "kanagawa" }
    use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
    use { 'folke/todo-comments.nvim' }
    use { 'numToStr/Comment.nvim' }
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'romgrk/barbar.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
    use { 'dstein64/nvim-scrollview' }
    use { 'windwp/nvim-autopairs' }
    use { 'lukas-reineke/indent-blankline.nvim' }
    use { 'ggandor/leap.nvim' }
    use { 'lukas-reineke/virt-column.nvim' }
    use { 'AckslD/nvim-neoclip.lua' }
    use { 'nathom/filetype.nvim' }
    
    use { 'lewis6991/impatient.nvim' }
    use { 'https://github.com/NMAC427/guess-indent.nvim' }

    use { 'rmagatti/auto-session' }
    use { 'L3MON4D3/LuaSnip' }
    use { 'neovim/nvim-lspconfig' }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', requires = { { 'p00f/nvim-ts-rainbow' },
                                                                             { 'nvim-treesitter/nvim-treesitter-refactor' },
                                                                             { 'nvim-treesitter/nvim-treesitter-textobjects' },
                                                                             { 'JoosepAlviste/nvim-ts-context-commentstring' } } }

    use { 'hrsh7th/nvim-cmp', requires = { { 'saadparwaiz1/cmp_luasnip', requires = { 'L3MON4D3/LuaSnip' } },
                                           { 'hrsh7th/cmp-nvim-lsp', requires = { 'neovim/nvim-lspconfig' } },
                                           { 'onsails/lspkind-nvim' },
                                           { 'ray-x/cmp-treesitter', requires = { 'nvim-treesitter/nvim-treesitter' } },
                                           { 'hrsh7th/cmp-path' },
                                           { 'hrsh7th/cmp-cmdline' } } }

    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' },
                                                        { 'kyazdani42/nvim-web-devicons' },
                                                        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
                                                        { 'rmagatti/session-lens', requires = { 'rmagatti/auto-session' } } } }
end)

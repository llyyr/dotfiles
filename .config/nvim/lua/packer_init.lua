vim.cmd [[packadd packer.nvim]]

packer = require('packer')

packer.init({
    git = {
        clone_timeout = 600,
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
    use { 'nvim-tree/nvim-web-devicons' }
    use { 'nvim-lua/plenary.nvim' }

    use { 'luisiacc/gruvbox-baby' }
    use { 'hoob3rt/lualine.nvim' }
    use { 'folke/todo-comments.nvim' }
    use { 'numToStr/Comment.nvim' }
    use { 'lewis6991/gitsigns.nvim' }
    use { 'romgrk/barbar.nvim', wants = "nvim-web-devicons" }
    use { 'dstein64/nvim-scrollview' }
    use { 'windwp/nvim-autopairs' }
    use { 'lukas-reineke/indent-blankline.nvim' }
    use { 'ggandor/leap.nvim' }
    use { 'AckslD/nvim-neoclip.lua' }

    use { 'lewis6991/impatient.nvim' }
    use { 'https://github.com/NMAC427/guess-indent.nvim' }

    use { 'rmagatti/auto-session' }
    use { 'L3MON4D3/LuaSnip' }
    use { 'neovim/nvim-lspconfig' }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', requires = { { 'p00f/nvim-ts-rainbow' },
                                                                             { 'nvim-treesitter/nvim-treesitter-refactor' },
                                                                             { 'nvim-treesitter/nvim-treesitter-textobjects' },
                                                                             { 'JoosepAlviste/nvim-ts-context-commentstring' } } }

    use { 'hrsh7th/nvim-cmp', requires = { { 'saadparwaiz1/cmp_luasnip' },
                                           { 'hrsh7th/cmp-nvim-lsp' },
                                           { 'onsails/lspkind-nvim' },
                                           { 'ray-x/cmp-treesitter' },
                                           { 'hrsh7th/cmp-path' },
                                           { 'hrsh7th/cmp-cmdline' } } }

    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } }
end)

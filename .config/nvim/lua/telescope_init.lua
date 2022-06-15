local telescope = require('telescope')

telescope.setup({
    defaults = {
        dynamic_preview_title = true,
    },
    pickers = {
        find_files = {
        },
    },
})

telescope.load_extension('fzf')
telescope.load_extension('neoclip')
telescope.load_extension('session-lens')

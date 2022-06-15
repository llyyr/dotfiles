--require("nvim-treesitter.install").prefer_git = true

require('nvim-treesitter.configs').setup({
    -- one of "all", "maintained", or a list
    ensure_installed = { "c", "cpp", "bash", "comment", "css", "cuda",
                         "dot", "glsl", "go", "html", "javascript", 
                         "julia", "latex", "lua", "make", "python", "rst", 
                         "json", "yaml" },

    ignore_install = { },        -- List of parsers to ignore installing
    refactor = {
        highlight_definitions   = { enable = false },
        highlight_current_scope = { enable = false },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },
    },
    textobjects = {
        move = {
            enable    = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border = 'single',
            peek_definition_code = {
                ["<leader>dF"] = "@function.outer",
                ["<leader>df"] = "@class.outer",
            },
        },
    },
    indent = {
        enable = false,
    },
    highlight = {
        enable = true,         -- false will disable the whole extension
--        disable = { "" },  -- list of language that will be disabled

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection    = "gnn",
            node_incremental  = "grn",
            scope_incremental = "grc",
            node_decremental  = "grm",
        },
    },
})

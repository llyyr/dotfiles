require('filetype').setup({
    overrides = {
        extensions = {
            -- Set the filetype of *.h files to c, NOT cpp
            h = "c",
            asm = "nasm",
            S = "asm",
        },
    },
})

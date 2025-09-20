local M = {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = "main" },
    { "nvim-treesitter/nvim-treesitter-context" },
  }
}

M.config = function()
  require("nvim-treesitter").install({ "c", "cpp", "bash", "comment", "css",
  "dot", "glsl", "go", "html", "haskell" ,"javascript", "java", "julia", "latex",
  "lua", "make", "python", "rst", "json", "yaml", "meson", "markdown", "rust",
  "scss", "zig" })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = require("nvim-treesitter").get_installed(),
    callback = function()
      vim.treesitter.start()
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M

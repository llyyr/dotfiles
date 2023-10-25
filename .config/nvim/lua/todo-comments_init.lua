return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = false,
    highlight = {
      before = "",
      keyword = "bg",
      after = "",
      comments_only = true,
    },
  }
}

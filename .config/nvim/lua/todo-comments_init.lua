return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
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

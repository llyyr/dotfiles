return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      panel = {
        enabled = true,
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = true,
  },
}

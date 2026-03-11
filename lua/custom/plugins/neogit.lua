return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gs", "<cmd>Neogit<CR>", desc = "Git status (Neogit)" },
    { "<leader>gc", "<cmd>Neogit commit<CR>", desc = "Git commit" },
    { "<leader>gp", "<cmd>Neogit push<CR>", desc = "Git push" },
    { "<leader>gl", "<cmd>Neogit pull<CR>", desc = "Git pull" },
  },
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
  },
}

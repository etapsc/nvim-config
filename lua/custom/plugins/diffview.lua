return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff view" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git file history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Git branch history" },
    { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
  },
  opts = {
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
    keymaps = {
      view = { { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" } } },
      file_panel = { { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" } } },
      file_history_panel = { { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" } } },
    },
  },
}

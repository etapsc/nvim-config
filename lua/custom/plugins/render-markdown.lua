return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- markdown + markdown_inline parsers (already installed)
    "nvim-tree/nvim-web-devicons", -- icon provider
  },
  opts = {},
  keys = {
    -- Toggle in-buffer rendering for the current markdown file
    { "<leader>mp", "<cmd>RenderMarkdown toggle<cr>", desc = "[M]arkdown [p]review toggle" },
  },
}

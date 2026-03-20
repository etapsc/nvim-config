return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install && git checkout -- yarn.lock",
    config = function()
      vim.g.mkdp_auto_start = 0
    end,
  },
}

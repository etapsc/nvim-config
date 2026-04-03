return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>sP", function() require("spectre").toggle() end, desc = "Search & replace (project)" },
    { "<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Search & replace (current file)" },
    { "<leader>sp", function() require("spectre").open_visual({ select_word = true }) end, mode = "v", desc = "Search & replace selection" },
  },
  opts = {},
}

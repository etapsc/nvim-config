return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    }

    vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
    vim.keymap.set("n", "<leader>x", function()
      require("mini.bufremove").delete()
    end, { desc = "Close buffer" })
    vim.keymap.set("n", "<leader>X", "<cmd>BufferLinePickClose<CR>", { desc = "Pick buffer to close" })    
  end,
}


return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        treesitter = true,
        telescope = true,
        neotree = true,
        lsp_trouble = true,
        mason = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        which_key = true,
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = false },
      },
    },
    init = function()
      local themes = { "catppuccin", "tokyonight" }
      local current = 1
      vim.cmd.colorscheme(themes[current])
      vim.keymap.set("n", "<leader>ut", function()
        current = current % #themes + 1
        vim.cmd.colorscheme(themes[current])
        print("Theme: " .. themes[current])
      end, { desc = "Toggle Theme" })
    end,
  },
}

return {
  {
    "snacks.nvim",
    opts = {
      indent = {
        enabled = false, -- using blink.indent instead
        scope = { enabled = false },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>.", false },
      { "<leader>e", false },
      { "<leader>E", false },
    },
    opts = {
      explorer = {
        enabled = false,
      },
    },
  },
  { "catppuccin/nvim", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
}

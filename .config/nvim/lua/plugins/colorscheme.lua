return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "xeind/nightingale.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightingale").setup({
        transparent = true, -- set to true for transparent background
      })
    end,
  },
  { "rebelot/kanagawa.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightingale",
    },
  },
}

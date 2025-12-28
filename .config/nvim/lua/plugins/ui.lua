return {
  {
    -- blazing fast statusline for neovim
    "sontungexpt/witch-line",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false, -- Almost component is lazy load by default. So you can set lazy to false
    opts = {},
  },
  {
    "saghen/blink.indent",
    --- @module 'blink.indent'
    --- @type blink.indent.Config
    -- opts = {},
  },
}

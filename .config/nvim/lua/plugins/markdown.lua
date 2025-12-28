return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    -- Moved highlight creation out of opts as suggested by plugin maintainer
    -- There was no issue, but it was creating unnecessary noise when ran
    -- :checkhealth render-markdown
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/138#issuecomment-2295422741
    opts = {
      bullet = {
        enabled = true,
      },
      checkbox = {
        enabled = true,
        position = "inline",
        unchecked = {
          icon = "   󰄱 ",
          highlight = "RenderMarkdownUnchecked",
          scope_highlight = nil,
        },
        checked = {
          icon = "   󰱒 ",
          highlight = "RenderMarkdownChecked",
          scope_highlight = nil,
        },
      },
      html = {
        enabled = true,
        comment = {
          conceal = false,
        },
      },
      link = {
        image = vim.g.neovim_mode == "skitty" and "" or "󰥶 ",
        custom = {
          youtu = { pattern = "youtu%.be", icon = "󰗃 " },
        },
      },
      heading = {
        sign = false,
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        backgrounds = {
          "Headline1Bg",
          "Headline2Bg",
          "Headline3Bg",
          "Headline4Bg",
          "Headline5Bg",
          "Headline6Bg",
        },
        foregrounds = {
          "Headline1Fg",
          "Headline2Fg",
          "Headline3Fg",
          "Headline4Fg",
          "Headline5Fg",
          "Headline6Fg",
        },
      },
      code = {
        style = "none",
      },
    },
  },
  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
  },
  {
    "OXY2DEV/markdoc.nvim",
  },
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      {
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    init = function()
      vim.g.mkdp_page_title = "${name}"
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1001,
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = function()
      if vim.g.neovide then return end
      require("image").setup({
        backend = "kitty",
        kitty_method = "normal",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
          html = {
            enabled = true,
          },
          css = {
            enabled = true,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 40,
        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = true,
        tmux_show_only_in_active_window = true,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
      })
    end,
  },
}

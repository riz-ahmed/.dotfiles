if vim.g.vscode then
    -- vs code extensions
else
    -- neovim extensions
    require("rizAhmed.plugins-used")
    require("rizAhmed.core.options")
    require("rizAhmed.core.keymaps")
    require("rizAhmed.core.colorscheme")
    require("rizAhmed.plugins.autopairs")
    require("rizAhmed.plugins.comments")
    require("rizAhmed.plugins.lualine")
    require("rizAhmed.plugins.nvim-tree")
    require("rizAhmed.plugins.telescope")
    require("rizAhmed.plugins.treesitter")
    require("rizAhmed.plugins.leap")
    require("rizAhmed.plugins.coc")
    require("rizAhmed.plugins.vimwiki")
    -- require("rizAhmed.plugins.which-key")
    require("rizAhmed.plugins.glow")
    require("rizAhmed.plugins.coloriser")

    --transparent background
    -- vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]
    -- vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
    -- vim.cmd[[hi clear LineNr]]
    -- vim.cmd[[hi clear SignColumn]]
    --
    -- vim.g.netrw_browser_split=0
    -- vim.g.netrw_banner=0
    -- vim.g.netrw_winsize=25
end

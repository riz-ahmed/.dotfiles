local setup, vimtree = pcall(require, "nvim-tree")
if not setup then
    return 
end

-- require'nvim-web-devicons'.get_icon(filename, c, { default = true })
-- require'nvim-web-devicons'.get_icon(filename, lua, { default = true })

-- recommended setting according to the nvim-tree documentation
vim.g.loaded_netwr = 1
vim.g.loaded_netrwPlugin = 1

-- change color of the arrow to blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

vimtree.setup{
    sync_root_with_cwd = true,
    renderer = {
        highlight_opened_files = "all",
    },
}

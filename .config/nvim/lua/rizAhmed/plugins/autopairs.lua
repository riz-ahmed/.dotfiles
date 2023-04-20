local autopair_setup, autopair = pcall(require, "nvim-autopairs")
if not autopair_setup then
    print("autopair setup didn't work")
    return 
end

autopair.setup({
    map_cr = true
})

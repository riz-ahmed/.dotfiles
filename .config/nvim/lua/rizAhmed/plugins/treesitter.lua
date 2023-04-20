local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup({
    highlight = {
        enable = true,
    },
    -- eanble indentations
    indent = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    -- ensure the following to be installed
    enusre_installed = {
        "c", "cpp", "python", "java", "bash", "vim", "lua",  "rust", "make", "regex", "toml", "yaml", "json",
    },
    -- auto-isntall above parses if they are missing
    auto_install = true,

    -- disable regex highlighting (regex is another syntax hightlighter in nvim)
    additional_vim_regex_highlighting = true, 

    -- multicolored brackets in the code
    rainbow = {
        enable = true,
        --extenden_mode = true, -- also for html tags
    },
})

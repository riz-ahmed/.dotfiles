local tele_setup, builtin = pcall(require, "telescope.builtin")
if not tele_setup then
    return
end

vim.keymap.set('n', '<Space>ff', builtin.find_files, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fb', builtin.buffers, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
vim.keymap.set('n', '<Space>fc', builtin.grep_string,{}) -- searches for the definitions for the highlighted string

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf') -- accroding to fzf documentation

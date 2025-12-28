---@diagnostic disable: undefined-global
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map Esc to <C-\><C-n> in terminal mode to enter normal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {desc = 'Terminal: Esc to Normal mode'})

local opt = vim.opt -- for concisness

-- line numbers
opt.number = true -- for displaying the line numbers
opt.relativenumber = true -- for displaying relative line numbers

-- opt.noncompatible = true

-- tabs and indentations
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true                   -- to ignore upper and lower cases while searching
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
-- opt.guicursor = ""
opt.background = "dark"
opt.signcolumn = "yes"

-- fix backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- ensures that the yanked items from VIM are copied over to the clipboard (this is useful when copying over items to programs outside VIM)

-- enable splitting up of the windows inside VIM
opt.splitbelow = true
opt.splitright = true

-- text editing
opt.iskeyword:append("-") -- ensures that the words seprated by "-" are considered as a single word

-- enable wildmenu (this enables to view command and file list options)
opt.wildmenu = true
opt.wildignorecase = true
--opt.wildignore+=\*.git/\*
--
--

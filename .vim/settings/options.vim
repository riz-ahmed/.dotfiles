filetype plugin indent on    " required
set background=dark
set termguicolors		"enable 256 Term gui colors
set number 			"display the abs number
set relativenumber		"display the relative numbers
set nocompatible		"to make vim not pretend like VI set number set relativenumber set tabstop=4 set shiftwidth=4
filetype plugin on		
set autoindent			"automatically indent when adding a new line
set hls 			"hihglight search
set showmatch			"show matches for braces, parenthesis etc.,
set ic				"ignore case while searching (ic shot for ignorecase)
set smartcase			"used along with set ic to make the whole of the string search case-insensitve
set incsearch			"vim will match each of letter of the string as typed in
runtime ftplugin/man.vim	"turn on man pages (type :Man), accessing MAN pages from vim
"set spell			"spell check on
"set spelllang=en_us		"if spell check is turned on then check english for spelling
set wrap!			"no warping of the line that flows out of the screen
set cursorline			"hihgligh the line where the cursor is at
set showcmd			"when a command is in progress - show it
set ruler			"turn on status info at the bottom (percentage of page etc.,)
set showmode			"displays the current mode vim is in
set path+=**			"serach down the subfolders; provides tab-completion for all file-related tasks (making search recursive)

set wildmenu			" Display all matching files when we tab complete
set hidden			"vim won't prompt for saving files when switching buffers
syntax on 			"syntax highlighting

"set tabstops
set tabstop=8			"industry standard 8 char tabs
set shiftwidth=4		"standard 4 char indentation

set clipboard=unnamed		"copies / pasters from the clipboard
set clipboard=unnamedplus	"copies / pasters from the clipboard

"settings for netrw
let g:netrw_winsize=20		"window width

colorscheme slate		"default colorscheme

"airline (statusline) settings
let g:airline_theme='base16'

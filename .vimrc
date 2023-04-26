"plugins
call plug#begin()
Plug 'lucasprag/simpleblack'		"theme - not working in warp terminal
Plug 'preservim/tagbar'			"tagbar for viewing functions in the current file
Plug 'tpope/vim-surround'		"for surrounding text with quotes, brackets etc
Plug 'szw/vim-maximizer'		"maximizing screen (each of the splits)
Plug 'tpope/vim-vinegar'		"addtions to netrw
Plug 'junegunn/fzf.vim'			"fzf for fuzzy file search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

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

"settings for netrw
let g:netrw_winsize=20		"window width

colorscheme slate		"default colorscheme

nnoremap <SPACE> <Nop>   
let mapleader=" "	 	"make Space the leader key

imap jk <ESC>			

"custom keymaps from installed plugins
nmap <Leader>tb :TagbarToggle<CR>
nmap <Leader>sm :MaximizerToggle<CR>	
nmap <Leader>e :Vexplore<CR>

" fzf fuzzy file finder
nnoremap <silent> <Leader>ff :Files<CR>

"search for string patterns using ripgrep
nnoremap <silent> <Leader>fg :Rg<CR>

"new keymaps for toggle window splits
"nmap <Leader>sv :<C-w>v			"split window vertically
"nmap <Leader>sh :<C-w>s			"split window horizontall
"nmap <Leader>se :<C-w>=			"make split windows of equal length 
"nmap <Leader>sx :close<CR>			"close split window

"remapping <C-d> and <C-u> to make the cursor stay in the middle of the screen
nmap <C-d> <C-d>zz
nmap <c-u> <c-u>zz

"using abbrivations to expand words in insert mode
:ab ot to					"make corrections to 'to'

"vimwiki config to use MARKDOWN syntax on VIMWIKI home folder

let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

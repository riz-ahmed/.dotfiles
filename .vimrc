"plugins
call plug#begin()
Plug 'lucasprag/simpleblack'		"theme - not working in warp terminal
Plug 'preservim/nerdtree'		"NERDTree for vim - a file explorer
Plug 'preservim/tagbar'			"tagbar for viewing functions in the current file
call plug#end()

"plguins installed using vundle
set rtp+=~/.vim/bundle/Vundle.vim	"set vundle to the path
call vundle#begin()			"start of plugins to be installed
Plugin 'VundleVim/Vundle.vim'		"vundles plugin manager - required plugin by vundle
Plugin 'christoomey/vim-tmux-navigator'	"plugin for vim and tmux easier navigation
Plugin 'szw/vim-maximizer'		"plguin for easier split window navigation
Plugin 'https://gitlab.com/madyanov/gruber.vim'		"plguin for easier split window navigation
Plugin 'tpope/vim-surround'		"plugin to surround with quotes, braces etc.,
Plugin 'vimwiki/vimwiki'		"vimwiki
Plugin 'itchyny/calendar.vim'		"calender.vim plugin
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set background=dark
set termguicolors
set number 
set relativenumber
set nocompatible		"to make vim not pretend like VI set number set relativenumber set tabstop=4 set shiftwidth=4
filetype plugin on
set autoindent			"automatically indent when adding a new line
set hls 			"hihglight search
set showmatch			"show matches for braces, parenthesis etc.,
set ic
filetype off			"requried by vundle plugin manager
runtime ftplugin/man.vim	"turn on man pages (type :Man), accessing MAN pages from vim
"set spell			"spell check on
"set spelllang=en_us		"if spell check is turned on then check english for spelling
set wrap!
set ignorecase
set smartcase
set cursorline
set showcmd		"when a command is in progress - show it
set ruler		"turn on status info at the bottom (percentage of page etc.,)
set showmode		"displays the current mode vim is in
set path+=**		"serach down the subfolders; provides tab-completion for all file-related tasks

" Display all matching files when we tab complete
set wildmenu

"syntax highlighting
syntax on 

"set tabstops
set tabstop=8		"industry standard 8 char tabs
set shiftwidth=4	"standard 4 char indentation


"default colorscheme
colorscheme default

"make space the global and local leader key
nnoremap <SPACE> <Nop>   "make sure space doesn't have any mappings before that
let mapleader=" "	 "make Space the leader key

imap jk <ESC>

"toggle Tagbar
nmap <Leader>tb :TagbarToggle<CR>
"toggle NERDTree
nmap <Leader>e :NERDTree<CR>

"toggle split window maximizer
nmap <Leader>sm :MaximizerToggle<CR>

"new keymaps for toggle window splits
nmap <Leader>sv :<C-w>v			"split window vertically
nmap <Leader>sh :<C-w>s			"split window horizontall
nmap <Leader>se :<C-w>=			"make split windows of equal length 
nmap <Leader>sx :close<CR>		"close split window

"remapping <C-d> and <C-u> to make the cursor stay in the middle of the screen
nmap <C-d> <C-d>zz
nmap <c-u> <c-u>zz

"using abbrivations to expand words in insert mode
:ab ot to

"vimwiki config to use MARKDOWN syntax on VIMWIKI home folder

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

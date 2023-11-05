"plugins
call plug#begin()
Plug 'lucasprag/simpleblack'		"theme - not working in warp terminal
Plug 'preservim/tagbar'			"tagbar for viewing functions in the current file
Plug 'tpope/vim-surround'		"for surrounding text with quotes, brackets etc
Plug 'szw/vim-maximizer'		"maximizing screen (each of the splits)
Plug 'tpope/vim-vinegar'		"addtions to netrw
Plug 'junegunn/fzf.vim'			"fzf for fuzzy file search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-commentary'		"comment using gc[motion] commmands
Plug 'vim-airline/vim-airline'		"light-weight status line
Plug 'vim-airline/vim-airline-themes'	"themes for airline
call plug#end()

"vimwiki config to use MARKDOWN syntax on VIMWIKI home folder

let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


nnoremap <SPACE> <Nop>   
let mapleader=" "	 	"make Space the leader key

imap jk <ESC>			
nnoremap <ESC><ESC> :noh<CR><ESC>

"custom keymaps from installed plugins
nmap <Leader>tb :TagbarToggle<CR>
nmap <Leader>sm :MaximizerToggle<CR>	
nmap <Leader>e :Vexplore<CR>

" fzf fuzzy file finder
nnoremap <silent> <Leader>ff :Files<CR>
"list buffers
nnoremap <silent> <Leader>fb :Buffers<CR>
"search for string patterns using ripgrep
nnoremap <silent> <Leader>fg :Rg<CR>
"list the git commits
nnoremap <silent> <Leader>gc :Commits<CR>

"remapping <C-d> and <C-u> to make the cursor stay in the middle of the screen
nmap <C-d> <C-d>zz
nmap <c-u> <c-u>zz

"using abbrivations to expand words in insert mode
:ab ot to					"make corrections to 'to'
:ab teh the					"make corrections to 'the'

" copy to clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p

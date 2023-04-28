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
:ab teh the					"make corrections to 'the'

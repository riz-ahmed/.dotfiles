-- Netrw options
vim.cmd([[
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_showhide=1
let g:netrw_winsize=20
]])
vim.cmd([[let g:netrw_localcopydircmd = 'cp -r']])
vim.cmd([[hi! link netrwMarkFile Search]])
vim.cmd([[
function! NetrwMapping()
nmap <buffer> H u
nmap <buffer> h -^
nmap <buffer> l <CR>

nmap <buffer> . gh
nmap <buffer> P <C-w>z
endfunction
augroup netrw_mapping
autocmd!
autocmd filetype netrw call NetrwMapping()
augroup END
]])

vim.cmd([[colorschem habamax]])

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = false -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Disable line wrap
opt.visualbell = true
opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- disable auto-commenting on the next line
vim.cmd([[autocmd Filetype * setlocal formatoptions-=c formatoptions-=r  formatoptions-=o]])

-- search down to subfolders
vim.cmd([[set path+=**]])

-- Auto-Complete - omnifunc
vim.cmd([[
set omnifunc=syntaxcomplete#Complete
set complete+=k
set completeopt=menu,menuone,noinsert
]])

-- Minimalist-Tab Complete
vim.cmd([[inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
  if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfun]])

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

-- Minimalist status line
vim.cmd([[
	set laststatus=2
	set statusline=
	set statusline+=%2*
	set statusline+=%{StatuslineMode()}
	set statusline+=\ 
	set statusline+=%1*
	set statusline+=\ 
	set statusline+=%3*
	set statusline+=<
	set statusline+=-
	set statusline+=\ 
	set statusline+=%f
	set statusline+=\ 
	set statusline+=-
	set statusline+=>
	set statusline+=\ 
	set statusline+=%4*
	set statusline+=%m
	set statusline+=%=
	set statusline+=%h
	set statusline+=%r
	set statusline+=%4*
	set statusline+=%c
	set statusline+=/
	set statusline+=%l
	set statusline+=/
	set statusline+=%L
	set statusline+=\ 
	set statusline+=%1*
	set statusline+=|
	set statusline+=%y
	set statusline+=\ 
	set statusline+=%4*
	set statusline+=%P
	set statusline+=\ 
	set statusline+=%3*
	set statusline+=t:
	set statusline+=%n
	set statusline+=\ 
  hi User2 ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black
  hi User1 ctermbg=brown ctermfg=white guibg=black guifg=white
  hi User3 ctermbg=brown  ctermfg=lightcyan guibg=black guifg=lightblue
  hi User4 ctermbg=brown ctermfg=green guibg=black guifg=lightgreen
  function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
  return "NORMAL"
  elseif l:mode==#"V"
  return "VISUAL LINE"
  elseif l:mode==?"v"
  return "VISUAL"
  elseif l:mode==#"i"
  return "INSERT"
  elseif l:mode ==# "\<C-V>"
  return "V-BLOCK"
  elseif l:mode==#"R"
  return "REPLACE"
  elseif l:mode==?"s"
  return "SELECT"
  elseif l:mode==#"t"
  return "TERMINAL"
  elseif l:mode==#"c"
  return "COMMAND"
  elseif l:mode==#"!"
  return "SHELL"
  else
  return "VIM"
  endif
  endfunction
]])

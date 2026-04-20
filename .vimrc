"	            __                            
"	    __  __ /\_\    ___ ___   _ __   ___   
"	   /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\ 
"	 __\ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/ 
"	/\_\\ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
"	\/_/ \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
"                                         

" showing numbers
set number
set relativenumber

" enabling syntax highlighting
syntax on

" changing color scheme to dark
set background=dark

" tab settings
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" setting automatic indentation
set autoindent

" disabling line wrap
set nowrap

" showing incomplete commands
set showcmd

" showing matching braces
set showmatch

" setting search options
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <leader><space> :nohlsearch<CR>

" redrawing only when needed
set lazyredraw

" enabling mouse
set mouse=a

" enabling statusline
set laststatus=3

" enabling autocompletion menu after pressing TAB
set wildmenu

" make wildmenu behave like Bash completion
set wildmode=list:longest

" building new statusline
function! GetCurrentBranch()
	return system("git branch 2> /dev/null | grep \"\*\" | awk \'{print $2}\' | tr -d \'\\n\'")
endfunction

function! CreateBranchStr()
	let l:currentBranch = GetCurrentBranch()
	return strlen(currentBranch) > 0 ? "  ".l:currentBranch.' ' : ''
endfunction

" setting branch info
set statusline=%#CursorLineNr#
set statusline+=%{CreateBranchStr()} 

" setting file info
set statusline+=%#StatusLineTerm#
set statusline+=\ %f
set statusline+=\ %m\ 
set statusline+=%=
set statusline+=%y 
set statusline+=\ %#IncSearch#
set statusline+=\ %l,%c
set statusline+=\ %#DiffText#
set statusline+=\ %p%%\ 

" enabling autocompletion
set autocomplete
set complete=.^5,w^5,b^5,u^5
set completeopt=menuone,noselect,popup

inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <CR>     pumvisible() ? "\<C-y>" : "\<CR>"

" enabling omnifunc
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" adding tag file
set tags+=~/.vim/systags

" adding window remaps
" horizontal split
nnoremap <space>s <c-w>s
" vertical split
nnoremap <space>v <c-w>v
" close current window
nnoremap <space>c <c-w>c
" close current buffer
nnoremap <space>x :bd<CR>
" close all windows except current
nnoremap <space>o <c-w>o
" window navigation
nnoremap <space>h <c-w>h 
nnoremap <space>j <c-w>j 
nnoremap <space>k <c-w>k 
nnoremap <space>l <c-w>l 

" yanking text to system clipboard
vnoremap cp "+y

" terminal remaps
tnoremap <esc> <c-\><c-n>

" function to make active window more noticeable
augroup LineHighlighting
    autocmd!
    " highlighting cursor line and column
    autocmd WinEnter * set cursorline
    autocmd WinEnter * set cursorcolumn
    autocmd WinEnter * set colorcolumn=80

    " removing highlighting
    autocmd WinLeave * set nocursorline
    autocmd WinLeave * set nocursorcolumn
    autocmd WinLeave * set colorcolumn=0
augroup END

" colorscheme
colorscheme gruvbox 

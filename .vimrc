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

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

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

set statusline=

" setting branch info
set statusline+=%#CursorLineNr#
set statusline+=%{CreateBranchStr()} 

" setting file info
set statusline+=%#StatusLineTerm#
set statusline+=\ %f
set statusline+=\ %m\ 
set statusline+=%=
set statusline+=%y 
set statusline+=\ %#ColorColumn#
set statusline+=\ %l,%c
set statusline+=\ %#QuickFixLine#
set statusline+=\ %p%%\ 

" enabling omnifunc
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" adding tag file
set tags+=~/.vim/systags

" configuring Netrw
" changing netrw's window size
let g:netrw_winsize = 10

" hiding netrw's banner
let g:netrw_banner = 0

" Keep the current directory and the browsing
" directory synced
let g:netrw_keepdir = 0

" adding netrw key bindings
" opening Netrw in current file's directory
nnoremap <leader>dd	:Lexplore %:p:h<CR>

" opening Netrw in current working directory
nnoremap <leader>da :Lexplore<CR>

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

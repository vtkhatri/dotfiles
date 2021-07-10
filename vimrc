" globals?
let mapleader=" "
set nocompatible
set t_Co=256
set omnifunc=syntaxcomplete#Complete
syntax enable
filetype plugin indent on
set encoding=utf-8
set path+=**

" tabbing
set ai
set tabstop=8 softtabstop=0 shiftwidth=8 smarttab

" organized backup and undo files
set backup
set backupdir=~/.vim/bkps/
set undofile
set undodir=~/.vim/undos/

" colors
set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" gutter numbering
set nu
set relativenumber

" CleverTab not working as intended
" function! CleverTab()
" 	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
" 		return "\<Tab>"
" 	else
" 		return "\<C-N>"
" 	endif
" endfunction
" inoremap <Tab> <C-R>=CleverTab()<CR>

" search
set hlsearch
set incsearch
set ignorecase
set smartcase

" tabbing in :
set wildmenu
set wildmode=list:longest,full

" completion
set complete+=kspell             " dictionary
set completeopt=menuone,longest  " behavior of complete menu
set shortmess+=c                 " don't print status message on completion

" netrw
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" maps
map ; :

map <leader><leader> :b#<CR>

map <leader>v <c-w>v
map <leader>s <c-w>s
map <leader>h <c-w>h
map <leader>j <c-w>j
map <leader>k <c-w>k
map <leader>l <c-w>l

map <leader>/ :nohlsearch<CR>     " clear search highlight
map <leader>p :tabe ~/post.md<CR> " open post-it file
map <leader>$ :s/\s\+$//g<CR>     " remove whitespace at the end of lines

map <leader>q :%bd<bar>e#<CR>     " delete all buffers except current

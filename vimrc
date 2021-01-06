" let g:Powerline_symbols = 'unicode'
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

set background=dark
set laststatus=2
set backspace=indent,eol,start

set expandtab
set tabstop=4
set shiftwidth=4

"set cursorcolumn
"set cursorline
highlight CursorLine ctermbg=darkgray cterm=none

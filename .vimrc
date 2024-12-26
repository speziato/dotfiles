set nocompatible
filetype on
filetype plugin on

set number relativenumber
set nu rnu
set cursorline

set expandtab
set nobackup

set incsearch
set noshowmode
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" List your plugins here
" Plugins
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()
set laststatus=2
let g:nord_uniform_status_lines = 1
let g:nord_cursor_line_number_background = 1
let g:lightline = { 'colorscheme': 'nord' }
colorscheme nord

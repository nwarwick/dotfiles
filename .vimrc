" Minimal .vimrc for quick vim edits (Neovim/LazyVim is primary editor)
" No plugins - just sensible defaults

set nocompatible
filetype plugin indent on
syntax on

" Basic settings
set tabstop=2
set shiftwidth=2
set expandtab
set number relativenumber
set mouse=a
set autoindent
set smartindent
set hlsearch
set incsearch
set ignorecase
set smartcase
set ruler
set showcmd
set wildmenu
set backspace=indent,eol,start
set laststatus=2

" No bells
set noerrorbells visualbell t_vb=

" Swap files to /tmp
set swapfile
set dir=/tmp

" Essential keybindings
let mapleader = ","
inoremap jj <Esc>

" Window navigation
noremap <silent> <C-l> <c-w>l
noremap <silent> <C-h> <c-w>h
noremap <silent> <C-k> <c-w>k
noremap <silent> <C-j> <c-w>j

" Quick save
nnoremap <leader>w :w<CR>

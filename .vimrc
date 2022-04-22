set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'dense-analysis/ale'
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'morhetz/gruvbox'
Plugin 'airblade/vim-gitgutter'
Plugin 'mattn/emmet-vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" End plugin code

set tabstop=2
set noerrorbells visualbell t_vb=
set mouse=a
set background=dark
" Show relative line numbers
set number relativenumber
set rtp+=/usr/local/opt/fzf
" Write swp files to /tmp instead of current directory
set swapfile
set dir=/tmp

let mapleader = ","
syntax enable
colorscheme gruvbox
let $BAT_THEME='gruvbox'

" Disable arrow keys
noremap! <Up> <NOP>
noremap <Up> <NOP>
noremap! <Down> <NOP>
noremap <Down> <NOP>
noremap! <Left> <NOP>
noremap <Left> <NOP>
noremap! <Right> <NOP>
noremap <Right> <NOP>

" set moving between splits to ctrl+hjkl
noremap <silent> <C-l> <c-w>l
noremap <silent> <C-h> <c-w>h
noremap <silent> <C-k> <c-w>k
noremap <silent> <C-j> <c-w>j

" Shortcut for split
noremap <C-\> :vsp<CR>

" NERDTree keybinds
nnoremap <C-m> :NERDTreeFind<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Fugitive keybinds
nnoremap <leader>gs :G<CR>

" FZF keybinds
nnoremap <leader>p :Files<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>g :GF?<CR>

" ALE Config
let g:ale_fix_on_save = 1
let g:ale_fixers = {
			\		'*': ['remove_trailing_lines', 'trim_whitespace'],
			\		'javascript': ['prettier', 'eslint'],
			\		'typescript': ['prettier', 'eslint'],
			\		'typescriptreact': ['prettier', 'eslint'],
			\		'ruby': ['rubocop'],
			\		'css': ['prettier'],
			\		'scss': ['prettier'],
			\		'html': ['prettier']
			\	}

" Coc config
let g:coc_node_path = '/Users/nwarwick/.nvm/versions/node/v14.15.5/bin/node'

" EMMET Config
" redefine trigger key
let g:user_emmet_leader_key=','


" handling setting and unsetting BAT_THEME for fzf.vim
augroup update_bat_theme
    autocmd!
    autocmd colorscheme * call ToggleBatEnvVar()
augroup end
function ToggleBatEnvVar()
    if (&background == "light")
        let $BAT_THEME='Monokai Extended Light'
    else
        let $BAT_THEME=''
    endif
endfunction

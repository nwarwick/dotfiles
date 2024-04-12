set nocompatible
filetype off

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'dense-analysis/ale'
Plug 'vim-ruby/vim-ruby'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off

set tabstop=2
set noerrorbells visualbell t_vb=
set mouse=a
" Show relative line numbers
set number relativenumber
" Write swp files to /tmp instead of current directory
set swapfile
set dir=/tmp

let mapleader = ","
syntax on " Changed from 'enable'

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

" FZF keybinds
nnoremap <leader>p :Files<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>g :GF?<CR>

" Coc config
le g:coc_node_path = '/Users/nickwarwick/.asdf/shims/node'

" ALE Config (for code linting)
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

" EMMET Config
" redefine trigger key
let g:user_emmet_leader_key=','

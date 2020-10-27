set number
set tabstop=2
set noerrorbells visualbell t_vb=
set mouse=a
set omnifunc=syntaxcomplete#Complete
set rtp+=/usr/local/opt/fzf

" Theme
colorscheme solarized8
syntax on
set background=dark

" 80 char delimeter
" set colorcolumn=80
" highlight ColorColumn ctermbg=0 guibg=lightgrey

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

" add more convenient mapping for ESC 
imap jj <Esc>

" ALE Settings
let g:ale_fix_on_save = 1
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'typescript': ['prettier', 'eslint'],  'typescriptreact': ['prettier', 'eslint'], 'ruby': ['rubocop'], 'css': ['prettier'], 'scss': ['prettier'], 'html': ['prettier']}

" EMMET Config
" redefine trigger key
let g:user_emmet_leader_key=','

" vundle start
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" gen purpose
Plugin 'tpope/vim-sensible'

" gen programming
" Plugin 'scrooloose/syntastic.git'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
" Plugin 'tpope/vim-unimpaired'
Plugin 'Valloric/YouCompleteMe'
Plugin 'dense-analysis/ale'
Plugin 'argtextobj.vim'
Plugin 'majutsushi/tagbar'
Plugin 'milkypostman/vim-togglelist'
Plugin 'junegunn/vim-easy-align'
" Plugin 'python-rope/ropevim'

" files
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" markup
Plugin 'tpope/vim-markdown'
Plugin 'lervag/vimtex'
Plugin 'esalter-va/vim-checklist'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'cespare/vim-toml'
" Plugin 'gu-fan/riv.vim'

" python
Plugin 'python-mode/python-mode'
Plugin 'cjrh/vim-conda'
Plugin 'tmhedberg/SimpylFold'
Plugin 'heavenshell/vim-pydocstring'

" style
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'luochen1990/rainbow'
Plugin 'Yggdroot/indentLine'
Plugin 'morhetz/gruvbox'
Plugin 'liuchengxu/space-vim-theme'

" util
Plugin 'RRethy/vim-illuminate'

" vundle end
call vundle#end()
filetype plugin indent on

syntax on

" leaders
let mapleader = ' '
let maplocalleader = ','

" backup files
set backupdir=~/.vim_backup//
set noswapfile
set undodir=~/.vim_undo//

" history and undo
" set history=1000  " vim-sensible
set undolevels=1000

" cursor always in the middle of the screen
set scrolloff=999

" line numbers
set relativenumber
set number

" more natural split directions
set splitbelow
set splitright

" enables copy/paste between vim instances
set clipboard=unnamed

" search options
set ignorecase
set smartcase
" set incsearch  " vim-sensible
set showmatch
set hlsearch

" expand tabs as white-spaces
set tabstop=2
set softtabstop=2
set shiftwidth=0
set expandtab

" exit insert mode
inoremap kj <esc>

" file movement
nnoremap j gj
nnoremap k gk

" toggle linewrap
noremap <leader>w :set wrap!<cr>

" move across panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" move across buffers
nnoremap <C-i> :bp<cr>
nnoremap <C-o> :bn<cr>

" move away from buffers without writing first
set hidden

" move across jump locations
" nnoremap <leader>i <C-i>
" nnoremap <leader>o <C-o>

" move across quickfixes
nnoremap <leader>i :cp<cr>
nnoremap <leader>o :cn<cr>

" latex flavor
let g:tex_flavor='latex'
au BufNewFile,BufRead *.tikz set filetype=tex  " treat .tikz like .tex

" markdown
let g:markdown_fenced_languages = ['html', 'python', 'r', 'bash=sh']
let g:markdown_syntax_conceal = 0

" vim-notes
let g:notes_directories = ['~/notes']

" " backspace over anything in insert
" set backspace=indent,eol,start  " vim-sensible

"" solarized
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

"" gruvbox
" set background=dark
" colorscheme gruvbox

" space-vim-theme
" set term=screen-256color
" set background=dark
" colorscheme space_vim_theme

" indentLine
" set concealcursor=0
let g:indentLine_color_term = 239
let g:indentLine_color_dark = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor=0

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
" let g:airline_theme = 'gruvbox'
" let g:airline_theme = 'angr'
" let g:airline_theme = 'wombat'
" let g:airline_theme = 'term'
" let g:airline_theme = 'bubblegum'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" rainbow
let g:rainbow_active = 1

" " syntastic
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" ale
let g:ale_linters = { 'python': ['pylint', 'mypy'], 'markdown': ['mdl'], 'tex': ['chktex', 'writegood'] }
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_fixers = { 'python': ['isort', 'black'] }
let g:ale_fix_on_save = 1

let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_black_options = '--skip-string-normalization --line-length 80'

let g:ale_tex_chktex_options = '-I -n 1 -n 3 -n 36'

" python-mode
" let g:pymode_python = 'python3'  " cannot run :py3 after running :python
" let g:pymode_breakpoint_cmd = '__import__("ipdb").set_trace()  # XXX BREAKPOINT'
let g:pymode_breakpoint_cmd = 'breakpoint()  # XXX BREAKPOINT'
let g:pymode_lint = 0

" vim-conda
let g:conda_startup_msg_suppress = 1

" pydocstring
let g:pydocstring_enable_mapping = 0
let g:pydocstring_enable_comment = 0
let g:pydocstring_doq_path = '/home/bais/anaconda3/bin/doq'
let g:pydocstring_formatter = 'google'

" simpylfold
let g:SimpylFold_fold_import = 0

" ctrlp
let g:ctrlp_user_command = 'ag -l --nocolor'
nnoremap <C-t> :CtrlPTag<cr>

" tagbar
nnoremap <leader>t :TagbarToggle<cr>

" YouCompleteMe
"
map <leader>yg :YcmCompleter GoTo<cr>
map <leader>yd :YcmCompleter GetDoc<cr>
map <leader>yt :YcmCompleter GetType<cr>
map <leader>ye :YcmShowDetailedDiagnostics<cr>
map <leader>yl :YcmDiags<cr>
map <leader>yr :YcmCompleter GoToReferences<cr>

" vim-checklist
nnoremap <leader>ct :ChecklistToggleCheckbox<cr>
nnoremap <leader>ce :ChecklistEnableCheckbox<cr>
nnoremap <leader>cd :ChecklistDisableCheckbox<cr>
vnoremap <leader>ct :ChecklistToggleCheckbox<cr>
vnoremap <leader>ce :ChecklistEnableCheckbox<cr>
vnoremap <leader>cd :ChecklistDisableCheckbox<cr>

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" misc
function TODO_inc()
  :s/XXX/DONE/e
  :s/TODO/XXX/e
endfunction

function TODO_dec()
  :s/XXX/TODO/e
  :s/DONE/XXX/e
endfunction

nnoremap <leader>+ :call TODO_inc()<cr>
nnoremap <leader>- :call TODO_dec()<cr>
vnoremap <leader>+ :call TODO_inc()<cr>
vnoremap <leader>- :call TODO_dec()<cr>

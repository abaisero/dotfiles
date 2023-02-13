" required by vim-polyglot
" set nocompatible

" install vim-plug if not available
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" gen purpose
Plug 'tpope/vim-sensible'

" lsp
Plug 'neovim/nvim-lspconfig'
" Plug 'williamboman/nvim-lsp-installer'

" text objects
" Plug 'vim-scripts/argtextobj.vim' " obsolete by wellle/targets.vim
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" gen programming
Plug 'tpope/vim-commentary'
Plug 'vim-test/vim-test'

Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

" editing
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
" Plug 'xolox/vim-misc'
" Plug 'tpope/vim-unimpaired'
" Plug 'majutsushi/tagbar'
Plug 'milkypostman/vim-togglelist'
Plug 'junegunn/vim-easy-align'

" integration with external programs
Plug 'tpope/vim-fugitive'
Plug 'python-rope/ropevim'
Plug 'tpope/vim-dispatch'

" navigation
Plug 'psliwka/vim-smoothie'

" autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'ludovicchabant/vim-gutentags'

" finders
" Plug 'scrooloose/nerdtree'
Plug 'nvim-lua/plenary.nvim' " prereq telescope
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder, nvim only
Plug 'ThePrimeagen/harpoon'

" markup
" Plug 'tpope/vim-markdown'
Plug 'lervag/vimtex'
Plug 'esalter-va/vim-checklist'
" Plug 'xolox/vim-notes'
Plug 'cespare/vim-toml'
" Plug 'gu-fan/riv.vim'

Plug 'nvim-neorg/neorg', { 'tag': '0.0.18' }
Plug 'nvim-neorg/neorg-telescope'

" python
" Plug 'python-mode/python-mode'
Plug 'vim-python/python-syntax'
" Plug 'cjrh/vim-conda' " TODO do I want this?
Plug 'heavenshell/vim-pydocstring'

" gui
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'airblade/vim-gitgutter' " sounds interesting, but can't get it to work

" improves syntax highlighting, suggested by spaceduck
Plug 'sheerun/vim-polyglot'
Plug 'luochen1990/rainbow'
" Plug 'Yggdroot/indentLine'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'RRethy/vim-illuminate'

" colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'nikolvs/vim-sunbather'
Plug 'widatama/vim-phoenix'

call plug#end()

lua <<EOF 

-- AUTOCOMPLETE
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm { select = true, },
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'neorg' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help'},
    { name = 'ultisnips' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 4},
  },

})

-- LSP STUFF

-- to add color-coded borders to diagnostic floats, the following works
-- https://github.com/neovim/neovim/issues/16627
-- https://neovim.discourse.group/t/lsp-diagnostics-how-and-where-to-retrieve-severity-level-to-customise-border-color/1679/3
-- https://neovim.discourse.group/t/lsp-diagnostics-how-and-where-to-retrieve-severity-level-to-customise-border-color/1679/7
-- it works, but it's a bit overly complicated.  Instead, I'll use a simpler method which adds rounded borders (albeit not color-coded)
-- https://www.reddit.com/r/neovim/comments/u7vuas/lsp_ui_customization/
vim.diagnostic.config {
  update_in_insert = true,
  float = {
    border = 'rounded',
  }
}

capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.texlab.setup { capabilities = capabilities, }
require'lspconfig'.pyright.setup { capabilities = capabilities, }
require'lspconfig'.solargraph.setup { capabilities = capabilities, }
require'lspconfig'.clangd.setup { capabilities = capabilities, }
require'lspconfig'.clojure_lsp.setup { capabilities = capabilities, }
require'lspconfig'.efm.setup { capabilities = capabilities, }

-- call this before tree-sitter setup because the parser is in early stages
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "norg", "norg_meta", "ruby", "clojure" },
  highlight = {
    enable = true,
    disable = {"rst", "markdown"},
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["a,"] = "@parameter.outer",
        ["i,"] = "@parameter.inner",
      },
    },
  }
}

require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.gtd.base"] = {
            config = {
                displayers = {
                    projects = {
                        show_completed_projects = true,
                        show_projects_without_tasks = false,
                        },
                    },
                workspace = "home"
                },
            }, -- Load `getting things done` module
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.integrations.telescope"] = {}, -- Enable the telescope module
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
        config = {
            workspaces = {
                home = "~/neorg",
                }
            }
        },
    ["core.norg.completion"] = {
        config = {
            engine = "nvim-cmp"
        }
    },
},
}

EOF 

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

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

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

" autocomplete
set wildmenu
set wildmode=longest:full,full
set completeopt=menu,menuone,noselect
set complete-=i  " do not complete from imported files -- to slow

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
" smth broken in nvim doesn't allow it to differentiate between <C-i> and <Tab>
nnoremap <Tab> :bp<cr>
nnoremap <C-o> :bn<cr>

" move away from buffers without writing first
set hidden

" move across quickfixes
nnoremap <leader>i :cp<cr>
nnoremap <leader>o :cn<cr>

" neorg
nnoremap <localleader>nc <cmd>Neorg toggle-concealer<CR>

" latex flavor
let g:tex_flavor='latex'
au BufNewFile,BufRead *.tikz set filetype=tex  " treat .tikz like .tex

" markdown
" let g:markdown_fenced_languages = ['html', 'python', 'r', 'bash=sh']
" let g:markdown_syntax_conceal = 0

" vim-notes
let g:notes_directories = ['~/notes']

" " backspace over anything in insert
" set backspace=indent,eol,start  " vim-sensible

" colorscheme
if exists('+termguicolors')
  " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" smoothie
" let g:smoothie_experimental_mappings = 'true'

" indentLine
let g:indentLine_color_term = 239
let g:indentLine_color_dark = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor=0

set background=dark
colorscheme phoenix
PhoenixOrange
hi MatchParen               guibg=#191919 guifg=#C88623 gui=NONE      ctermfg=235   ctermbg=208

" vim-airline
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'zenburn'
" let g:airline_theme = 'raven'
let g:airline_theme = 'minimalist'
let g:airline#extensions#tabline#enabled = 1

" rainbow
let g:rainbow_active = 1

" python-mode
" let g:pymode_breakpoint_cmd = 'breakpoint()  # XXX BREAKPOINT'
" let g:pymode_lint = 0

" vim-conda
let g:conda_startup_msg_suppress = 1

" pydocstring
let g:pydocstring_enable_mapping = 0
let g:pydocstring_enable_comment = 0
let g:pydocstring_doq_path = '/home/bais/anaconda3/bin/doq'
let g:pydocstring_formatter = 'google'

" plug
nmap <leader>pi <cmd>PlugInstall<CR>
nmap <leader>pu <cmd>PlugUpdate<CR>
nmap <leader>pc <cmd>PlugClean<CR>

" lsp mappings
nnoremap <silent> <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_prev()<CR>
" vim.lsp.buf.formatting_seq_sync is deprecated, use vim.lsp.buf.format
" nnoremap <silent> F :w<CR><cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>:w<CR>
" autocmd BufWritePre *.py lua vim.lsp.buf.formatting_seq_sync()
" autocmd BufWritePre *.rb lua vim.lsp.buf.formatting_seq_sync()
" autocmd BufWritePre *.tex lua vim.lsp.buf.formatting_seq_sync()
" " autocmd BufWritePre *.bib lua vim.lsp.buf.formatting_seq_sync()
nnoremap <silent> F :w<CR><cmd>lua vim.lsp.buf.format()<CR>:w<CR>
autocmd BufWritePre *.py lua vim.lsp.buf.format()
autocmd BufWritePre *.rb lua vim.lsp.buf.format()
autocmd BufWritePre *.tex lua vim.lsp.buf.format()
" autocmd BufWritePre *.bib lua vim.lsp.buf.format()

" pymode
nmap <leader>b <cmd>call OperateTag(line('.'), 'breakpoint()  # XXX BREAKPOINT')<CR>

" taken and customized from pymode https://github.com/python-mode/python-mode/blob/develop/autoload/pymode/breakpoint.vim
fun! OperateTag(lnum, tag)
    let line = getline(a:lnum)
    if strridx(line, a:tag) != -1
        normal dd
    else
        let plnum = prevnonblank(a:lnum)
        if &expandtab
            let indents = repeat(' ', indent(plnum))
        else
            let indents = repeat("\t", plnum / &shiftwidth)
        endif

        call append(line('.')-1, indents.a:tag)
        normal k
        :Commentary
    endif

    " Save file without any events
    noautocmd write

endfunction

" telescope
nmap <leader>ff <cmd>Telescope find_files<CR>
nmap <leader>fg <cmd>Telescope live_grep<CR>
nmap <leader>fb <cmd>Telescope buffers<CR>
nmap <Leader>ft <cmd>lua require'telescope.builtin'.tags{}<CR>

" testing
nmap <silent> <leader>tn <cmd>TestNearest<CR>
nmap <silent> <leader>tf <cmd>TestFile<CR>
nmap <silent> <leader>ts <cmd>TestSuite<CR>
nmap <silent> <leader>tl <cmd>TestLast<CR>
nmap <silent> <leader>tv <cmd>TestVisit<CR>

" harpoon mappings
nmap <leader>hh <cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>
nmap <leader>ha <cmd>lua require("harpoon.mark").add_file()<CR>
nmap <leader>hd <cmd>lua require("harpoon.mark").rm_file()<CR>
nmap <leader>hc <cmd>lua require("harpoon.mark").clear_all()<CR>
nmap <leader>hn <cmd>lua require("harpoon.ui").nav_next()<CR>
nmap <leader>hp <cmd>lua require("harpoon.ui").nav_prev()<CR>
" nmap <leader>h1 <cmd>lua require("harpoon.ui").nav_file(1)<CR>
" nmap <leader>h2 <cmd>lua require("harpoon.ui").nav_file(2)<CR>
" nmap <leader>h3 <cmd>lua require("harpoon.ui").nav_file(3)<CR>
" nmap <leader>h4 <cmd>lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>h1 :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>h2 :lua require("harpoon.term").gotoTerminal(2)<CR>

" tagbar
" nnoremap <leader>t :TagbarToggle<cr>

" vim-easytags
:set tags=./tags;$HOME
:let g:easytags_dynamic_files = 1

" YouCompleteMe
" map <leader>yg :YcmCompleter GoTo<cr>
" map <leader>yd :YcmCompleter GetDoc<cr>
" map <leader>yt :YcmCompleter GetType<cr>
" map <leader>ye :YcmShowDetailedDiagnostics<cr>
" map <leader>yl :YcmDiags<cr>
" map <leader>yr :YcmCompleter GoToReferences<cr>

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

" nocommit
let g:nocommit_tag = 'TODO NOCOMMIT'

fun! NoCommit(lnum)
    let line = getline(a:lnum)
    if strridx(line, g:nocommit_tag) != -1
        normal dd
    else
        let plnum = prevnonblank(a:lnum)
        if &expandtab
            let indents = repeat(' ', indent(plnum))
        else
            let indents = repeat("\t", plnum / &shiftwidth)
        endif

        call append(line('.')-1, indents.g:nocommit_tag)
        normal k
        :Commentary
    endif

    " Save file without any events
    noautocmd write

endfunction

nnoremap <leader>n <cmd>call OperateTag(line('.'), 'TODO NOCOMMIT')<CR>

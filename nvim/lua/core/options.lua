-- backup files
vim.opt.backupdir = vim.env.HOME .. '/.vim_backup//'
vim.opt.swapfile = false
vim.opt.undodir = vim.env.HOME .. '/.vim_undo//'

-- history and undo
vim.opt.history = 1000  -- vim-sensible
vim.opt.undolevels = 1000

-- cursor always in the middle of the screen
vim.opt.scrolloff = 999

-- line numbers
vim.opt.relativenumber =true
vim.opt.number =true

-- more natural split directions
vim.opt.splitbelow = true
vim.opt.splitright = true

-- enables copy/paste between vim instances
vim.opt.clipboard:append 'unnamedplus'

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

---- search options
vim.opt.wildmenu = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true -- vim-sensible
vim.opt.showmatch = true

-- expand tabs as white-spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

-- autocomplete
vim.opt.wildmode = 'longest:full,full'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.complete:remove 'i'

vim.g.latex_flavor = 'latex'
vim.g.python3_host_skip_check = 1
vim.g.python3_host_prog = vim.env.HOME .. '/venvs/vim/bin/python3'

-- -- filetype stuff
-- -- doesn't work
-- vim.opt.do_filetype_lua = 1
-- vim.opt.did_load_filetypes = 0

-- doesn't work
-- vim.filetype.add({
--   extension = {
--     norg = 'norg',
--     -- tikz = 'tex',
--     typ = 'typst',
--     typst = 'typst',
--   },
-- })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.norg',
  command = 'setfiletype norg',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.tikz',
  command = 'setfiletype tex',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.typ',
  command = 'setfiletype typst',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.typst',
  command = 'setfiletype typst',
})

-- to add color-coded borders to diagnostic floats, the following works
-- https://github.com/neovim/neovim/issues/16627
-- https://neovim.discourse.group/t/lsp-diagnostics-how-and-where-to-retrieve-severity-level-to-customise-border-color/1679/3
-- https://neovim.discourse.group/t/lsp-diagnostics-how-and-where-to-retrieve-severity-level-to-customise-border-color/1679/7
-- it works, but it's a bit overly complicated.  Instead, I'll use a simpler method which adds rounded borders (albeit not color-coded)
-- https://www.reddit.com/r/neovim/comments/u7vuas/lsp_ui_customization/
vim.diagnostic.config {
  update_in_insert = true,
  float = { border = 'rounded' },
}

vim.opt.termguicolors = true

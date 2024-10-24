local map = require("core.utils").map

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- exit insert mode
map('i', 'kj', '<ESC>')

-- move across wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- move across panes
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- move across buffers
map('n', '<C-i>', ':bp<CR>')
map('n', '<C-o>', ':bn<CR>')

-- move across quickfix list
map('n', '<leader>p', ':cp<CR>')
map('n', '<leader>n', ':cn<CR>')

-- harpoon
map('n', '<leader>hh', function() require("harpoon.ui").toggle_quick_menu() end)
map('n', '<leader>ha', function() require("harpoon.mark").add_file() end)
map('n', '<leader>hd', function() require("harpoon.mark").rm_file() end)
map('n', '<leader>hc', function() require("harpoon.mark").clear_all() end)
map('n', '<leader>hn', function() require("harpoon.ui").nav_next() end)
map('n', '<leader>hp', function() require("harpoon.ui").nav_prev() end)
-- -- " nmap <leader>h1 <cmd>lua require("harpoon.ui").nav_file(1)<CR>
-- -- " nmap <leader>h2 <cmd>lua require("harpoon.ui").nav_file(2)<CR>
-- -- " nmap <leader>h3 <cmd>lua require("harpoon.ui").nav_file(3)<CR>
-- -- " nmap <leader>h4 <cmd>lua require("harpoon.ui").nav_file(4)<CR>
map('n', '<leader>h1', function() require("harpoon.term").gotoTerminal(1) end)
map('n', '<leader>h2', function() require("harpoon.term").gotoTerminal(2) end)

-- lsp
-- map('n', '<leader>gd', vim.lsp.buf.definition, { silent = true, desc = "Go to definition" })
-- map('n', '<leader>gr', vim.lsp.buf.references, { silent = true, desc = "Go to references" })
map('n', '<leader>gd', '<CMD>:Telescope lsp_definitions<CR>', { silent = true, desc = "Go to definition" })
map('n', '<leader>gr', '<CMD>:Telescope lsp_references<CR>', { silent = true, desc = "Go to references" })
map('n', 'K', vim.lsp.buf.hover, { silent = true, desc = "Show hover info" })
map('n', 'F', vim.lsp.buf.format, { silent = true, desc = "Run formatter" })

-- dap
map('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
map('n', '<leader>dc', function() require('dap').continue() end)
map('n', '<leader>ds', function() require('dap').step_over() end)
map('n', '<leader>di', function() require('dap').step_into() end)
map('n', '<leader>dr', function() require('osv').launch({ port = 8086 }) end)
-- map('n', '<leader>dr', function() require('osv').run_this() end)

-- move across diagnostics
map('n', '<C-p>', vim.diagnostic.goto_prev, { silent = true, desc = "Go to previous diagnostic" })
map('n', '<C-n>', vim.diagnostic.goto_next, { silent = true, desc = "Go to next diagnostic" })

-- neorg
map('n', '<leader>nc', ':Neorg toggle-concealer<CR>')

-- oil
map("n", "-", '<CMD>Oil<CR>', { desc = "Open parent directory" })

-- lazy
map('n', '<leader>pi', '<CMD>:Lazy update<CR>', { silent = true })
map('n', '<leader>pu', '<CMD>:Lazy update<CR>', { silent = true })
map('n', '<leader>pc', '<CMD>:Lazy clean<CR>', { silent = true })

-- telescope
map('n', '<leader>fb', '<CMD>:Telescope buffers<CR>')
map('n', '<leader>fc', '<CMD>:Telescope commands<CR>')
map('n', '<leader>fd', '<CMD>:Telescope diagnostics<CR>')
map('n', '<leader>ff', '<CMD>:Telescope find_files<CR>')
map('n', '<leader>fg', '<CMD>:Telescope live_grep<CR>')
map('n', '<leader>fgit', '<CMD>:Telescope git_files<CR>')
map('n', '<leader>fh', '<CMD>:Telescope help_tags<CR>')
map('n', '<leader>fk', '<CMD>:Telescope keymaps<CR>')
map('n', '<leader>fl', '<CMD>:Telescope loclist<CR>')
map('n', '<leader>flr', '<CMD>:Telescope lsp_references<CR>')
map('n', '<leader>ftd', '<CMD>:TodoTelescope<CR>')
map('n', '<leader>fq', '<CMD>:Telescope quickfix<CR>')

-- todo
map('n', '<leader>tdq', '<CMD>:TodoQuickFix<CR>')
map('n', '<leader>tdl', '<CMD>:TodoLocList<CR>')
map('n', '<leader>tdt', '<CMD>:TodoTrouble<CR>')

-- local operate_tag = require("core.utils").operate_tag
-- map('n', '<leader>b', function() operate_tag(vim.fn.line('.'), 'breakpoint()  # XXX BREAKPOINT') end)


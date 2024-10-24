local map = require("core.utils").map
local operate_tag = require("core.utils").operate_tag

local tag = [[require('debugger')() -- XXX BREAKPOINT]]
map('n', '<leader>b', function() operate_tag(vim.fn.line('.'), tag) end, { buffer = true })

-- AUTOCOMPLETE
local cmp = require('cmp')

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

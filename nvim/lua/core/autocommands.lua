vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'typst',
  callback = function()
    vim.opt_local.commentstring = [[// %s]]
  end,
})

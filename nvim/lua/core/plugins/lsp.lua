-- local map = require("core.utils").map

return {
  {
    "folke/neodev.nvim",
    dependencies = { 'hrsh7th/nvim-cmp' },
    lazy = true,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      require('neodev').setup()

      local client_capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)

      local lspconfig = require('lspconfig')
      lspconfig.hls.setup { capabilities = capabilities, }
      lspconfig.texlab.setup { capabilities = capabilities, }
      lspconfig.pyright.setup { capabilities = capabilities, }
      lspconfig.ruff.setup { capabilities = capabilities, }
      lspconfig.solargraph.setup { capabilities = capabilities, }
      lspconfig.clangd.setup { capabilities = capabilities, }
      lspconfig.clojure_lsp.setup { capabilities = capabilities, }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false, -- disable weird workspace request
            },
          },
        },
      }
      lspconfig.ts_ls.setup { capabilities = capabilities, }
      lspconfig.bashls.setup { capabilities = capabilities, }
      lspconfig.typst_lsp.setup { capabilities = capabilities, }
      lspconfig.efm.setup { capabilities = capabilities, }

      -- TODO: move this to keymaps file?
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- map('n', '<leader>gd', vim.lsp.buf.definition, { buffer = ev.buf, silent = true, desc = "Go to definition" })
          -- map('n', '<leader>gr', vim.lsp.buf.references, { buffer = ev.buf, silent = true, desc = "Go to references" })
          -- map('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, silent = true, desc = "Show hover info" })
          -- map('n', 'F', vim.lsp.buf.format, { buffer = ev.buf, silent = true, desc = "Run formatter" })
        end,
      })

      -- " vim.lsp.buf.formatting_seq_sync is deprecated, use vim.lsp.buf.format
      -- " nnoremap <silent> F :w<CR><cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>:w<CR>
      -- " autocmd BufWritePre *.py lua vim.lsp.buf.formatting_seq_sync()
      -- " autocmd BufWritePre *.rb lua vim.lsp.buf.formatting_seq_sync()
      -- " autocmd BufWritePre *.tex lua vim.lsp.buf.formatting_seq_sync()
      -- " " autocmd BufWritePre *.bib lua vim.lsp.buf.formatting_seq_sync()
      -- " nnoremap <silent> F :w<CR><cmd>lua vim.lsp.buf.format()<CR>:w<CR>
      -- nnoremap <silent> F <cmd>lua vim.lsp.buf.format({async = true})<CR>
      -- autocmd BufWritePre *.py lua vim.lsp.buf.format()
      -- " autocmd BufWritePre *.py lua vim.lsp.buf.format({async = true})
      -- autocmd BufWritePre *.rb lua vim.lsp.buf.format()
      -- autocmd BufWritePre *.tex lua vim.lsp.buf.format()
      -- autocmd BufWritePre *.js lua vim.lsp.buf.format()
      -- autocmd BufWritePre *.jsx lua vim.lsp.buf.format()
      -- autocmd BufWritePre *.ts lua vim.lsp.buf.format()
      -- autocmd BufWritePre *.tsx lua vim.lsp.buf.format()
      -- " autocmd BufWritePre *.bib lua vim.lsp.buf.format()
    end,
  },
}

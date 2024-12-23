-- local noirbuddy_lualine = require('noirbuddy.plugins.lualine')

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      icons_enabled = true,
      -- theme = noirbuddy_lualine.theme,
      theme = 'onedark',
    },
    tabline = {
      lualine_a = {'buffers'},
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {
        {'filename', file_status = true},
        {'diagnostics', sources = {'nvim_lsp'}},
      },
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'},
    },
  }
}

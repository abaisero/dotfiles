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
  ensure_installed = {
    "python",
    "ruby",
    "lua",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "json",
    "yaml",
    "bash",
    "toml",
    "norg",
    -- "norg_meta",
  },

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
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

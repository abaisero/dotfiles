return {
  -- gen purpose
  {
    'tpope/vim-sensible',
    lazy = false
  },

  -- navigation
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = 'Oil',
    config = true,
  },

  -- lsp
  -- 'williamboman/nvim-lsp-installer',

  -- text objects
  {
    'wellle/targets.vim',
    event = 'VeryLazy',
  },
  {
    'michaeljsmith/vim-indent-object',
    event = 'VeryLazy',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- gen programming
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = true,
  },
  'vim-test/vim-test',

  {
    'RishabhRD/nvim-cheat.sh',
    dependencies = { 'RishabhRD/popfix' },
    cmd = { 'Cheat', 'CheatWithoutComments' },
  },
  -- HACK: ok
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      'nvim-telescope/telescope.nvim',
    },
    cmd = {
      'TodoLocList',
      'TodoQuickFix',
      'TodoTelescope',
      'TodoTrouble',
    },
    config = true,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },

  -- editing
  'tpope/vim-surround',
  'tommcdo/vim-exchange',
  -- 'xolox/vim-misc',
  -- 'tpope/vim-unimpaired',
  'milkypostman/vim-togglelist',

  -- integration with external programs
  'tpope/vim-fugitive',
  {
    'python-rope/ropevim',
    ft = 'python',
  },
  'tpope/vim-dispatch',

  -- navigation
  {
    'psliwka/vim-smoothie',
    event = 'VeryLazy',
  },
  {
    'ggandor/leap.nvim',
    event = 'VeryLazy',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'ggandor/flit.nvim',
    dependencies = {
      'ggandor/leap.nvim',
      'tpope/vim-repeat',
    },
    event = 'VeryLazy',
    config = true,
    enabled = false, -- not impressed, leap is good enough. probably remove this eventually
  },

  -- autocomplete
  'github/copilot.vim',
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    event = 'InsertEnter',
  },
  "kkoomen/vim-doge",

  'SirVer/ultisnips',
  'honza/vim-snippets',
  'quangnguyen30192/cmp-nvim-ultisnips',
  'ludovicchabant/vim-gutentags',

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
  },

  -- finders
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      'nvim-telescope/telescope-fzf-native.nvim',
      'sharkdp/fd',
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = { 'Telescope' },
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    config = true,
  },

  -- markup
  {
    'lervag/vimtex',
    lazy = false, -- internally lazy
  },
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  -- 'esalter-va/vim-checklist',
  -- {  -- obsolete by tree sitter?
  --   'cespare/vim-toml',
  --   ft = 'toml',
  -- },

  -- typst
  {
    'kaarmu/typst.vim',
    ft = 'typst',
  },

  -- python
  {
    'vim-python/python-syntax',
    ft = 'python',
  },

  -- ui
  { -- dependency for other plugins
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
      vim.notify = require('notify')
    end
  },
  -- improves syntax highlighting, suggested by spaceduck
  -- {
  --   'sheerun/vim-polyglot',
  --   lazy = false
  -- },
  -- 'luochen1990/rainbow',
  -- 'Yggdroot/indentLine',
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    event = 'VeryLazy',
    build = ":TSUpdate",
  },
  {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
      require('illuminate').configure()
    end,
  },

  -- dap
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'jbyuki/one-small-step-for-vimkind' },
  },
  {
    'jbyuki/one-small-step-for-vimkind',
    config = function()
      local dap = require('dap')

      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = 'Run this file',
          start_neovim = {},
        },
        {
          type = 'nlua',
          request = 'attach',
          name = 'Attach to running Neovim instance (port = 8086)',
        }
      }

      dap.adapters.nlua = function(callback, config)
        local adapter = {
          type = 'server',
          host = config.host or '127.0.0.1',
          port = config.port or 8086
        }

        if config.start_neovim then
          local dap_run = dap.run
          dap.run = function(c)
            adapter.port = c.port
            adapter.host = c.host
          end
          require('osv').run_this()
          dap.run = dap_run
        end

        callback(adapter)
      end
    end
  },
}

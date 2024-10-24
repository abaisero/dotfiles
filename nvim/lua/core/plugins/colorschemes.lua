return {
  { 'rafamadriz/neon', enabled = false },
  { 'altercation/vim-colors-solarized', enabled = false },
  { 'joshdick/onedark.vim', enabled = false },
  { 'EdenEast/nightfox.nvim', enabled = false },
  { 'tyrannicaltoucan/vim-quantum', enabled = false },
  { 'nikolvs/vim-sunbather', enabled = false },
  { 'widatama/vim-phoenix', enabled = false },
  -- { 'tjdevries/colorbuddy.nvim', branch = 'dev' },
  { 'jesseleite/nvim-noirbuddy',
    dependencies = {
    -- 'tjdevries/colorbuddy.nvim'
    { 'tjdevries/colorbuddy.nvim', branch = 'dev' },
    },
    lazy = false,
    priority = 1000,
    opts = { preset = 'miami-nights' },
    config = true,
    -- config = function()
    --   -- vim.opt.background = 'dark'
    --   -- vim.cmd.colorscheme 'phoenix'
    --   -- vim.cmd 'PhoenixOrange'
    --   -- -- vim.cmd.hi('MatchParen guibg=#191919 guifg=#C88623 gui=NONE ctermfg=235 ctermbg=208')
    -- -- end,
  },
}

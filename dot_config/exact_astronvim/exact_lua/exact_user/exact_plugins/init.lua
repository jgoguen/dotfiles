return {
  ['akinsho/bufferline.nvim'] = { disable = true },
  ['akinsho/toggleterm.nvim'] = { disable = true },
  ["Darazaki/indent-o-matic"] = { disable = true },
  ['folke/which-key.nvim'] = { disable = true },
  ['goolord/alpha-nvim'] = { disable = true },
  ['Shatur/neovim-session-manager'] = { disable = true },
  ['stevearc/aerial.nvim'] = { disable = true },

  {
    'crispgm/nvim-go',
    ft = { 'go' },
    config = function()
      require('go').setup({
        auto_lint = false,
        formatter = 'gofmt',
      })
    end,
  },
  {
    'folke/todo-comments.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require('todo-comments').setup({})
    end,
  },
  { 'folke/tokyonight.nvim' },
  {
    'folke/trouble.nvim',
    requires = {
      { 'folke/lsp-colors.nvim' },
      { 'kyazdani42/nvim-web-devicons' },
    },
    config = function()
      require('trouble').setup({
        fold_closed = '▸',
        fold_open = '▾',
        open_split = { '<C-x>', 's' },
        open_vsplit = { '<C-v>', 'i', 'v' },
        open_tab = { '<C-t>', 't' },
        auto_open = true,
        auto_close = true,
        auto_preview = false,
        use_diagnostic_signs = true,
      })
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    after = 'nvim-cmp',
    config = function()
      astronvim.add_user_cmp_source('nvim_lsp_signature_help')
    end,
  },
  {
    'hrsh7th/cmp-nvim-lua',
    after = 'nvim-cmp',
    config = function()
      astronvim.add_user_cmp_source('nvim_lua')
    end,
  },
  { 'https://codeberg.org/jgoguen/tmpl.vim' },
  { 'junegunn/vader.vim' },
  {
    'kosayoda/nvim-lightbulb',
    requires = {
      { 'antoinemadec/FixCursorHold.nvim' },
    },
    config = function()
      require('nvim-lightbulb').setup({
        autocmd = {
          enabled = true,
        },
      })
    end,
  },
  { 'nathanaelkane/vim-indent-guides' },
  {
    'numToStr/FTerm.nvim',
    config = function()
      require('FTerm').setup({
        auto_close = false,
        border = "double",
      })
    end,
  },
  { 'nvim-telescope/telescope-symbols.nvim' },
  {
    'pangloss/vim-javascript',
    ft = { 'javascript' },
  },
  {
    'pearofducks/ansible-vim',
    ft = { 'ansible', 'yaml.ansible' },
  },
  {
    'plasticboy/vim-markdown',
    requires = {
      { 'vim-pandoc/vim-pandoc-syntax' },
      { 'godlygeek/tabular' },
    },
  },
  {
    'preservim/vimux',
    cond = function()
      local tmux_var = vim.fn.expand('$TMUX')
      return tmux_var ~= '$TMUX'
    end,
  },
  { 'ryanoasis/vim-devicons' },
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup()
    end,
  },
  { 'tmux-plugins/vim-tmux' },
  {
    'vim-airline/vim-airline',
    requires = {
      { 'tpope/vim-fugitive' },
      { 'vim-airline/vim-airline-themes' },
    },
  },
  {
    'vim-latex/vim-latex',
    ft = { 'latex', 'tex' }
  },
  {
    'vim-python/python-syntax',
    ft = { 'python' },
  },
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
}
